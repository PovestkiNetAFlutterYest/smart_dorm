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

  Future<void> incrementBring(String userId) async {
    var docs = await client
        .collection('water_supply')
        .where('userId', isEqualTo: userId)
        .get();
    var documentId = docs.docs[0].id;
    var numBottlesBrung = docs.docs[0].data()['numBottlesBrung'];

    var collection = FirebaseFirestore.instance.collection('water_supply');
    collection
        .doc(documentId) // <-- Doc ID where data should be updated.
        .update({"numBottlesBrung": numBottlesBrung + 1}) // <-- Updated data
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }
}
