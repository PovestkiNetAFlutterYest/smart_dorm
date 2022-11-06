abstract class WaterEvent {}

class IncrementWaterCountEvent extends WaterEvent {
  String userId;

  IncrementWaterCountEvent({required this.userId});
}
class RemindBringWaterEvent extends WaterEvent {
  String userId;

  RemindBringWaterEvent({required this.userId});
}

class UpdateQueueEvent extends WaterEvent {}