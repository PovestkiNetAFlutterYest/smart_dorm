import 'package:flutter/material.dart';

abstract class AddShowerSlotsEvent {}

class GetShowerSlotForCurrentUser extends AddShowerSlotsEvent {}

class UpdateStartTime extends AddShowerSlotsEvent {
  TimeOfDay startTime;

  UpdateStartTime({required this.startTime});
}

class UpdateEndTime extends AddShowerSlotsEvent {
  TimeOfDay endTime;

  UpdateEndTime({required this.endTime});
}