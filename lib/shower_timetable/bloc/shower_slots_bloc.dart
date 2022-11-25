import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/models/user.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_event.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_state.dart';
import 'package:smart_dorm/shower_timetable/dto/shower_timeslot.dart';
import '../resources/repository.dart';

class ShowerSlotsBloc extends Bloc<ShowerSlotsEvent, ShowerSlotsState> {
  final ShowerSlotsRepository repository;

  ShowerSlotsBloc(this.repository) : super(ShowerSlotsEmptyState()) {
    on<UpdateShowerSlotsEvent>((event, emit) async {
      try {
        List<ShowerTimeSlot> timeSlotsData =
            await repository.fetchShowerTimeSlot();
        List<Future<User>> usersDataFutures = [];
        for (var timeSlot in timeSlotsData) {
          usersDataFutures.add(repository.getUserById(timeSlot.userId));
        }
        var usersList = await Future.wait(usersDataFutures);
        emit(ShowerSlotsSuccessState(
            timeSlotsData: timeSlotsData, usersList: usersList));
      } on FirebaseException catch (e) {
        emit(ShowerSlotsFailedState());
      }
    });
  }
}