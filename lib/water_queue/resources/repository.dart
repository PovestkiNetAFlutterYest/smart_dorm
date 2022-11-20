import 'dart:async';
import 'package:smart_dorm/water_queue/dto/queue_item.dart';
import 'package:smart_dorm/water_queue/dto/water_bring_counter.dart';

import '../../auth/models/user.dart';
import '../bloc/generate_queue.dart';
import 'firebase_api.dart';

class WaterQueueRepository {
  final firebaseProvider = FirebaseAPI();

  Future<List<WaterSupplyItem>> getWaterEntries() =>
      firebaseProvider.getAllWaterData();

  Future<List<User>> getAllUsers() => firebaseProvider.getAllUsers();

  Future<List<DisplayQueueItem>> incrementWaterCounter(String userId) async {
    await firebaseProvider.incrementBring(userId);
    return await getQueue();
  }

  Future<List<DisplayQueueItem>> getQueue() async {
    List list = await Future.wait(
        [firebaseProvider.getAllWaterData(), firebaseProvider.getAllUsers()]);

    List<WaterSupplyItem> waterCount = list[0] as List<WaterSupplyItem>;
    List<User> users = list[1] as List<User>;

    List<DisplayQueueItem> items = generateQueue(waterCount, users);

    return items;
  }
}
