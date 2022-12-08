import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_dorm/auth/dto/user.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_event.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_state.dart';
import 'package:smart_dorm/shower_timetable/dto/shower_timeslot.dart';
import '../resources/repository.dart';

class ShowerSlotsBloc extends Bloc<ShowerSlotsEvent, ShowerSlotsState> {
  final ShowerSlotsRepository repository;

  num toNumericValue(Timestamp timestamp){
    DateTime dateTimeRowVal = DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch, isUtc: true);
    return dateTimeRowVal.hour+60 + dateTimeRowVal.minute;
  }

  bool checkOnInconsistency(List<ShowerTimeSlot> timeslots){
    for (var timeslot in timeslots) {
      for (var timeSlotToCompare in timeslots){
        print(toNumericValue(timeslot.startTime));
        if (toNumericValue(timeslot.startTime) < toNumericValue(timeSlotToCompare.startTime) && toNumericValue(timeslot.startTime) < toNumericValue(timeSlotToCompare.startTime));
      }
    }
    return true;
  }

  ShowerSlotsBloc(this.repository) : super(ShowerSlotsEmptyState()) {
    on<UpdateShowerSlotsEvent>((event, emit) async {
      try {
        List<ShowerTimeSlot> timeSlotsData =
            await repository.fetchShowerTimeSlot();
        print(checkOnInconsistency(timeSlotsData));
        List<Future<User?>> usersDataFutures = [];
        for (var timeSlot in timeSlotsData) {
          usersDataFutures.add(repository.getUserById(timeSlot.userId));
        }
        var usersList = await Future.wait(usersDataFutures);
        emit(ShowerSlotsSuccessState(
            timeSlotsData: timeSlotsData, usersList: usersList));
      } on FirebaseException catch (_) {
        emit(ShowerSlotsFailedState());
      }
    });
  }
}
