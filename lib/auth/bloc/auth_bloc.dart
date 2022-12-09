import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';
import 'package:smart_dorm/auth/bloc/auth_state.dart';
import 'package:smart_dorm/auth/dto/user.dart';
import 'package:smart_dorm/auth/dto/user_login_info.dart';
import '../../push_notification/main.dart';
import '../../shower_timetable/resources/repository.dart';
import '../../water_queue/resources/repository.dart';
import '../resources/google_signin_repository.dart';
import '../resources/local_storage_repository.dart';
import 'generate_new_room.dart';

const String networkErrorText = "Something went down, please try ones again";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInRepository signInRepository;
  final LocalStorageRepository localStorage;
  final WaterQueueRepository waterQueueRepository;
  final ShowerSlotsRepository showerSlotsRepository;

  AuthBloc(this.signInRepository, this.localStorage, this.waterQueueRepository, this.showerSlotsRepository)
      : super(AuthInitialState()) {
    on<SignInEvent>((event, emit) async {
      try {
        UserLoginInfo userInfo = await signInRepository.login();
        if (kDebugMode) {
          print("userInfo: $userInfo");
        }

        User? user = await waterQueueRepository.getUserById(userInfo.id);
        if (user != null) {
          // user exists in database

          await localStorage.setCurrentUser(user);
          await storeNotificationToken(user);

          if (kDebugMode) {
            print("Already attached to room!");
          }
          emit(ShowMainPageState());
        } else {
          // ask user whether to create room or join one
          emit(MakeChoiceState(userInfo));
        }
      } catch (e) {
        emit(AuthInitialState(message: networkErrorText));
      }
    });

    on<ShowMainPageEvent>((event, emit) {
      emit(ShowMainPageState());
    });

    on<CreateNewRoomEvent>((event, emit) async {
      try {
        // here ask to create new room or join
        // creating new user and adding it to database
        UserLoginInfo userInfo = event.userLoginInfo;

        Set<String> existingRoomIds = await waterQueueRepository.getAllRoomIds();
        String roomId = generateUniqueString(5, existingRoomIds);

        User newUser = User(userInfo.id, userInfo.name, roomId, userInfo.email);

        await Future.wait([
          waterQueueRepository.addUserToDB(newUser),
          localStorage.setCurrentUser(newUser),
          waterQueueRepository.createEmptyWaterCollection(newUser),
          storeNotificationToken(newUser),
          showerSlotsRepository.createEmptyShowerCollection(newUser),
        ]);

        emit(RoomCreatedState(newUser));
      } catch (e) {
        emit(AuthInitialState(message: networkErrorText));
      }
    });

    on<LeaveRoomEvent>((event, emit) async {
      try {
        print("leaving room");
        User user = localStorage.getCurrentUser();

        print("current user: $user");

        await Future.wait([
          signInRepository.logout(),
          waterQueueRepository.removeWaterEntryFromDB(user),
          showerSlotsRepository.removeShowerEntryFromDB(user),
          localStorage.clearCurrentUser(),
          waterQueueRepository.removeUserFromDB(user)
        ]);
        emit(AuthInitialState());
      } catch (e, stackTrace) {
        await FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: "Some internet issue");
        emit(AuthInitialState(message: networkErrorText));
      }
    });

    on<JoinRoomEvent>((event, emit) async {
      try {
        UserLoginInfo userLoginInfo = event.userLoginInfo;
        String roomId = event.roomId;

        Set<String> existingRoomIds = await waterQueueRepository.getAllRoomIds();

        if (!existingRoomIds.contains(roomId)) {
          emit(EnteredRoomIdDoNotExists());
        } else {
          User user = User(userLoginInfo.id, userLoginInfo.name, roomId,
              userLoginInfo.email);

          await Future.wait([
            localStorage.setCurrentUser(user),
            waterQueueRepository.addUserToDB(user),
            waterQueueRepository.createEmptyWaterCollection(user),
            showerSlotsRepository.createEmptyShowerCollection(user),
            storeNotificationToken(user),
          ]);

          emit(ShowMainPageState());
        }
      } catch (e, stackTrace) {
        await FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: "Some internet issue");
        emit(AuthInitialState(message: networkErrorText));
      }
    });
  }
}
