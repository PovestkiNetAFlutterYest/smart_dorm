import 'dart:async';
import 'package:smart_dorm/water_queue/dto/water_bring_counter.dart';

import '../../auth/models/user.dart';
import 'firebase_api.dart';

class WaterQueueRepository {
  final firebaseProvider = FirebaseAPI();

  Future<List<WaterSupplyItem>> getWaterEntries() =>
      firebaseProvider.getAllWaterData();

  Future<List<User>> getAllUsers() => firebaseProvider.getAllUsers();

  Future<void> incrementWaterCounter(String userId) =>
      firebaseProvider.incrementBring(userId);

  Future<Map<String, String>> mapUserIdToName() async {
    List<User> users = await getAllUsers();

    Map<String, String> userIdToName = {};
    for (var user in users) {
      userIdToName[user.userId] = user.name;
    }

    return userIdToName;
  }
}
