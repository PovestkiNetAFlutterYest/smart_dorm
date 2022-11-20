import '../dto/queue_item.dart';

abstract class WaterEvent {}

class IncrementWaterCountEvent extends WaterEvent {
  String userId;
  List<DisplayQueueItem> previousData;

  IncrementWaterCountEvent({required this.userId, required this.previousData});
}

class RemindBringWaterEvent extends WaterEvent {
  String userId;

  RemindBringWaterEvent({required this.userId});
}

class UpdateQueueEvent extends WaterEvent {}
