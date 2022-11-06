import '../dto/queue_item.dart';

abstract class WaterState {}

class WaterEmptyState extends WaterState {}

class WaterFailedState extends WaterState {}

class WaterSuccessState extends WaterState {
  final List<DisplayQueueItem> data;

  WaterSuccessState({required this.data});
}

class SuccessfullySavedLocally extends WaterSuccessState {
  SuccessfullySavedLocally({required super.data});
}

class SuccessfullySavedGlobally extends WaterSuccessState {
  SuccessfullySavedGlobally({required super.data});
}

class FailedSaveLocallyState extends WaterFailedState {}

class FailedSaveGloballyState extends WaterFailedState {}

class IncrementingCountState extends WaterState {}

// show dialog when doing this
class SuccessfullyRemindPersonState extends WaterState {}
