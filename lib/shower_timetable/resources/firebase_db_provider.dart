import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_dorm/auth/models/user.dart';
import 'package:smart_dorm/models/shower_timeslot.dart';

class FirebaseProvider {
  final client = FirebaseFirestore.instance;

  Future<List<ShowerTimeSlot>> getAllShowerTimeSlotData() async {
    QuerySnapshot snap = await client.collection('timeslots').get();
    List<QueryDocumentSnapshot<Object?>> timeslotDocs = snap.docs;
    List<ShowerTimeSlot> showerTimeSlotList = timeslotDocs
        .map((doc) =>
            ShowerTimeSlot.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return showerTimeSlotList;
  }

  Future<User> getUserById(String userId) async {
    QuerySnapshot snap = await client
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();
    User user = User.fromJson(snap.docs[0].data() as Map<String, dynamic>);
    return user;
  }
}
