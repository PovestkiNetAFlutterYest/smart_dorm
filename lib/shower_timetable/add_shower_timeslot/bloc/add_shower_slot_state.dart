import '../../dto/shower_timeslot.dart';

abstract class AddShowerSlotState {}

class AddShowerSlotEmptyState extends AddShowerSlotState {}

class AddShowerSlotSuccessState extends AddShowerSlotState {
  final ShowerTimeSlot timeSlotData;

  AddShowerSlotSuccessState({required this.timeSlotData});
}

class AddShowerSlotsFailedState extends AddShowerSlotState {}
