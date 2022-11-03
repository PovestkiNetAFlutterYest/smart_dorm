import 'package:cloud_firestore/cloud_firestore.dart';

class ShowerTimeSlot {
  late String userId;
  late String roomId;
  late Timestamp startTime;
  late Timestamp endTime;

  ShowerTimeSlot(this.userId, this.roomId, this.startTime, this.endTime);

  ShowerTimeSlot.fromJson(Map<String, dynamic> timeSlotRawData)
      : userId = timeSlotRawData['userId'],
        startTime = timeSlotRawData['startTime'],
        endTime = timeSlotRawData['endTime'],
        roomId = timeSlotRawData['roomId'];
}
