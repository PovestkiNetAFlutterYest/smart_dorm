import 'package:smart_dorm/auth/dto/user.dart';

import '../dto/shower_timeslot.dart';

abstract class ShowerSlotsState {}

class ShowerSlotsEmptyState extends ShowerSlotsState {}

class ShowerSlotsFailedState extends ShowerSlotsState {}

class ShowerSlotsSuccessState extends ShowerSlotsState {
  final List<ShowerTimeSlot> timeSlotsData;
  final List<User?> usersList;

  ShowerSlotsSuccessState(
      {required this.timeSlotsData, required this.usersList});
}

class CurrentShowerSlotSuccessState extends ShowerSlotsState {
  final ShowerTimeSlot timeSlotData;

  CurrentShowerSlotSuccessState(
      {required this.timeSlotData});
}
