import '../dto/queue_item.dart';

abstract class WaterState {}

class WaterEmptyState extends WaterState {}

class WaterFailedState extends WaterState {}

class WaterSuccessState extends WaterState {
  final List<DisplayQueueItem> data;

  WaterSuccessState({required this.data});
}

class SuccessfullySavedState extends WaterSuccessState {
  SuccessfullySavedState({required super.data});
}

class IncrementingCountState extends WaterState {
  List<DisplayQueueItem> previousData;

  IncrementingCountState(this.previousData);
}

// show dialog when doing this
class SuccessfullyRemindPersonState extends WaterState {}
