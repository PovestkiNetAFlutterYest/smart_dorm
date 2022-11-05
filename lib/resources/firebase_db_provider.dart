import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_dorm/models/water_bring_counter.dart';

import '../models/shower_timeslot.dart';
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

  Future<List<ShowerTimeSlot>> getAllShowerTimeSlotData() async {
    QuerySnapshot snap = await client.collection('timeslots').get();
    List<QueryDocumentSnapshot<Object?>> timeslotDocs = snap.docs;
    List<ShowerTimeSlot> showerTimeSlotList = timeslotDocs
        .map((doc) =>
            ShowerTimeSlot.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return showerTimeSlotList;
  }

  Future<List<User>> getAllUsers() async {
    QuerySnapshot querySnapshot = await client.collection('users').get();

    List<QueryDocumentSnapshot<Object?>> documents = querySnapshot.docs;
    List<User> list = documents
        .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return list;
  }

  Future<User> getUserById(String userId) async {
    QuerySnapshot snap = await client
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();
    User user = User.fromJson(snap.docs[0].data() as Map<String, dynamic>);
    return user;
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
