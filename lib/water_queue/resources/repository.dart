import 'dart:async';
import 'package:smart_dorm/water_queue/dto/queue_item.dart';
import 'package:smart_dorm/water_queue/dto/water_bring_counter.dart';
import 'package:collection/collection.dart';
import '../../auth/dto/user.dart';
import '../bloc/generate_queue.dart';
import 'firebase_api.dart';

class WaterQueueRepository {
  final firebaseProvider = FirebaseAPI();

  Future<List<WaterSupplyItem>> getWaterEntries() =>
      firebaseProvider.getAllWaterData();

  Future<List<User>> getAllUsers() => firebaseProvider.getAllUsers();

  Future<List<DisplayQueueItem>> incrementWaterCounter(User user) async {
    await firebaseProvider.incrementBring(user.id);
    return await getQueue(user);
  }

  Future<List<DisplayQueueItem>> getQueue(User user) async {
    List list = await Future.wait(
        [firebaseProvider.getAllWaterData(), firebaseProvider.getAllUsers()]);

    List<WaterSupplyItem> waterCount = list[0] as List<WaterSupplyItem>;
    List<User> users = list[1] as List<User>;

    List<DisplayQueueItem> items = generateQueue(waterCount, users, user);

    return items;
  }

  Future<Set<String>> getAllRoomIds() async {
    List<User> users = await getAllUsers();

    Set<String> roomIds = users.map((e) => e.roomId).toSet();
    return roomIds;
  }

  Future<User?> getUserById(String userId) async {
    List<User> users = await getAllUsers();

    return users.firstWhereOrNull((element) => element.id == userId);
  }

  Future<void> addUserToDB(User user) async {
    await firebaseProvider.client.collection('users').add(user.toJson());
  }
  
  Future<void> removeUserFromDB(User user) async {
    var docs = await firebaseProvider.client.collection('users').where('id', isEqualTo: user.id).get();

    String documentId = docs.docs[0].id;
    print("deleting documentId: $documentId");
    await firebaseProvider.client.collection('users').doc(documentId).delete();
  }

  Future<void> removeWaterEntryFromDB(User user) async {
    var docs = await firebaseProvider.client.collection('water_supply').where('userId', isEqualTo: user.id).get();

    String documentId = docs.docs[0].id;
    print("deleting documentId: $documentId");
    await firebaseProvider.client.collection('water_supply').doc(documentId).delete();
  }


  Future<void> createEmptyWaterCollection(User user) async {
    await firebaseProvider.client.collection('water_supply').add({
      'userId': user.id,
      'roomId': user.roomId,
      'numBottlesBrung': 0,
      'lastTimeBottleBrung': DateTime.now(),
    });


  }
}
