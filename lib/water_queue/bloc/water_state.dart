import 'package:smart_dorm/water_queue/dto/queue_item.dart';

abstract class WaterState {}

class WaterEmptyState extends WaterState {}

class SuccessfullyFetchQueueState extends WaterState {
  List<DisplayQueueItem> data;

  SuccessfullyFetchQueueState({required this.data});
}

class FailedFetchQueueState extends WaterState {}

class IncrementingWaterCountState extends WaterState {}

class SuccessfullyIncrementWaterCountState extends WaterState {}

class FailedIncrementWaterCountState extends WaterState {}

// show dialog when doing this
class SuccessfullyRemindPersonState extends WaterState {}
