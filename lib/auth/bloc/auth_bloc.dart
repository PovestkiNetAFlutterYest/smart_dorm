import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';
import 'package:smart_dorm/auth/bloc/auth_state.dart';
import 'package:smart_dorm/auth/dto/user.dart';
import 'package:smart_dorm/auth/dto/user_login_info.dart';
import '../../water_queue/resources/repository.dart';
import '../resources/google_signin_repository.dart';
import '../resources/local_storage_repository.dart';
import 'generate_new_room.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInRepository signInRepository;
  final LocalStorageRepository localStorage;
  final WaterQueueRepository firebase;

  AuthBloc(this.signInRepository, this.localStorage, this.firebase)
      : super(AuthInitialState()) {
    on<SignInEvent>((event, emit) async {
      UserLoginInfo userInfo = await signInRepository.login();
      if (kDebugMode) {
        print("userInfo: $userInfo");
      }

      User? user = await firebase.getUserById(userInfo.id);
      if (user != null) {
        // user exists in database

        localStorage.setCurrentUser(user);

        if (kDebugMode) {
          print("Already attached to room!");
        }
        emit(ShowMainPageState());
      } else {
        // ask user whether to create room or join one
        emit(MakeChoiceState(userInfo));
      }
    });

    on<ShowMainPageEvent>((event, emit) {
      emit(ShowMainPageState());
    });

    on<CreateNewRoomEvent>((event, emit) async {
      // here ask to create new room or join
      // creating new user and adding it to database
      UserLoginInfo userInfo = event.userLoginInfo;

      Set<String> existingRoomIds = await firebase.getAllRoomIds();
      String roomId = generateUniqueString(5, existingRoomIds);

      User newUser = User(userInfo.id, userInfo.name, roomId, userInfo.email);
      await firebase.addUserToDB(newUser);
      localStorage.setCurrentUser(newUser);
      emit(RoomCreatedState(newUser));
    });

    on<LeaveRoomEvent>((event, emit) async {
      User user = localStorage.getCurrentUser();

      await Future.wait([
        signInRepository.logout(),
        firebase.removeWaterEntryFromDB(user),
        localStorage.clearCurrentUser(),
        firebase.removeUserFromDB(user)
      ]);
      emit(AuthInitialState());
    });

    on<JoinRoomEvent>((event, emit) async {
      UserLoginInfo userLoginInfo = event.userLoginInfo;
      String roomId = event.roomId;

      Set<String> existingRoomIds = await firebase.getAllRoomIds();

      if (!existingRoomIds.contains(roomId)) {
        emit(EnteredRoomIdDoNotExists());
      } else {
        User user = User(
            userLoginInfo.id, userLoginInfo.name, roomId, userLoginInfo.email);

        await Future.wait([
          localStorage.setCurrentUser(user),
          firebase.addUserToDB(user),
          firebase.createEmptyWaterCollection(user)
        ]);

        emit(ShowMainPageState());
      }
    });
  }
}
