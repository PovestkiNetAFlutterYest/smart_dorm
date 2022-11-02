import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_dorm/models/water_bring_counter.dart';

import '../models/user.dart';

class FirebaseProvider {
  final client = FirebaseFirestore.instance;

  Future<List<WaterSupplyItem>> getAllWaterData() async {
    QuerySnapshot querySnapshot = await client.collection('water_supply').get();

    List<QueryDocumentSnapshot<Object?>> documents = querySnapshot.docs;
    List<WaterSupplyItem> list = documents
        .map((doc) =>
            WaterSupplyItem.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return list;
  }

  Future<List<User>> getAllUsers() async {
    QuerySnapshot querySnapshot = await client.collection('users').get();

    List<QueryDocumentSnapshot<Object?>> documents = querySnapshot.docs;
    List<User> list = documents
        .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return list;
  }
}
