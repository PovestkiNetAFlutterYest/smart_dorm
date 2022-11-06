import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_dorm/water_queue/dto/water_bring_counter.dart';

import '../../auth/models/user.dart';


class FirebaseAPI {
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

  Future<void> incrementBring(String userId) async {
    var docs = await client
        .collection('water_supply')
        .where('userId', isEqualTo: userId)
        .get();
    var documentId = docs.docs[0].id;
    final docRef = client.collection('water_supply').doc(documentId);

    // running transaction
    await client.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final newCounter = snapshot.get('numBottlesBrung') + 1;
      transaction.update(docRef, {"numBottlesBrung": newCounter});
    });
  }
}
