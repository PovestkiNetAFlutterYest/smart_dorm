import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/resources/local_storage_repository.dart';
import '../../dto/shower_timeslot.dart';
import '../../resources/repository.dart';
import 'add_shower_slot_event.dart';
import 'add_shower_slot_state.dart';

class AddShowerSlotsBloc extends Bloc<AddShowerSlotsEvent, AddShowerSlotState> {
  final ShowerSlotsRepository repository;
  final LocalStorageRepository localRepo;

  AddShowerSlotsBloc(this.repository, this.localRepo) : super(AddShowerSlotEmptyState()) {

    on<GetShowerSlotForCurrentUser>((event, emit) async {
      try {
        ShowerTimeSlot timeSlot = await repository.fetchShowerTimeslotByUser(localRepo.getCurrentUser());
        emit(AddShowerSlotSuccessState(
            timeSlotData: timeSlot
        ));
      } on FirebaseException catch (_) {
        emit(AddShowerSlotsFailedState());
      }
    });

    on<UpdateEndTime>((event, emit) async {
      try {
        TimeOfDay endTime = event.endTime;
        DateTime now = DateTime.now();
        DateTime dateTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
        await repository.updateTimeSlotEndTime(localRepo.getCurrentUser(), Timestamp.fromDate(dateTime));
        emit(AddShowerSlotEmptyState());
      } on FirebaseException catch (_) {
      emit(AddShowerSlotsFailedState());
      }
    });

    on<UpdateStartTime>((event, emit) async {
      try {
        TimeOfDay startTime = event.startTime;
        DateTime now = DateTime.now();
        DateTime dateTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
        await repository.updateTimeSlotStartTime(localRepo.getCurrentUser(), Timestamp.fromDate(dateTime));
        emit(AddShowerSlotEmptyState());
      } on FirebaseException catch (_) {
        emit(AddShowerSlotsFailedState());
      }
    });
  }
}
