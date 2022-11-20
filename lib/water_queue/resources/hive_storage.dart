import 'package:hive/hive.dart';
import 'package:smart_dorm/water_queue/bloc/generate_queue.dart';

import '../../auth/models/user.dart';
import '../dto/queue_item.dart';
import '../dto/water_bring_counter.dart';

class HiveStorage {
  late final Box<WaterSupplyItem> waterBox;
  late final Box<User> userBox;



  HiveStorage({required this.waterBox, required this.userBox});

  List<WaterSupplyItem> getWaterCountFromCache() => waterBox.values.toList();

  List<User> getUsersFromCache() => userBox.values.toList();

  Future<List<DisplayQueueItem>> incrementWaterCountCache(String userId) async {
    final userToUpdate = waterBox.values.firstWhere((e) => e.userId == userId);
    userToUpdate.count += 1;
    await userToUpdate.save();
    return getQueueCache();
  }

  List<DisplayQueueItem> getQueueCache() {
    final List<WaterSupplyItem> items = getWaterCountFromCache();
    final List<User> users = getUsersFromCache();

    final List<DisplayQueueItem> queue = generateQueue(items, users);
    return queue;
  }
}
