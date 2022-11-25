import '../dto/queue_item.dart';

abstract class WaterState {}

class WaterEmptyState extends WaterState {}

class WaterFailedState extends WaterState {}

class WaterSuccessState extends WaterState {
  final List<DisplayQueueItem> data;

  WaterSuccessState({required this.data});
}

// show dialog when doing this
class SuccessfullyRemindPersonState extends WaterState {}
