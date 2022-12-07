import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_dorm/auth/dto/user.dart';
import 'package:smart_dorm/shower_timetable/dto/shower_timeslot.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'firebase_db_provider.dart';

class ShowerSlotsRepository {
  final firebaseProvider = FirebaseProvider();

  Future<List<ShowerTimeSlot>> fetchShowerTimeSlot() =>
      firebaseProvider.getAllShowerTimeSlotData();

  Future<List<User>> getAllUsers() => firebaseProvider.getAllUsers();


  Future<User?> getUserById(String userId) async {
    List<User> users = await getAllUsers();
    return users.firstWhereOrNull((element) => element.id == userId);
  }

  Future<ShowerTimeSlot> fetchShowerTimeslotByUser(User user) =>
      firebaseProvider.fetchShowerTimeslotByUser(user);

  Future<void> updateTimeSlotStartTime(User user, Timestamp startTime) async {
    var docs =await firebaseProvider.client
        .collection('timeslots')
        .where('userId', isEqualTo: user.id)
        .get();
    var documentId = docs.docs[0].id;
    final docRef = FirebaseFirestore.instance.collection('timeslots').doc(documentId);

    await FirebaseFirestore.instance.runTransaction((transaction) async{
      transaction.update(docRef, {"startTime": startTime});
    });
  }

  Future<void> updateTimeSlotEndTime(User user, Timestamp endTime) async {
    var docs =await firebaseProvider.client  .collection('timeslots')
        .where('userId', isEqualTo: user.id)
        .get();
    var documentId = docs.docs[0].id;
    final docRef = FirebaseFirestore.instance.collection('timeslots').doc(documentId);

    await FirebaseFirestore.instance.runTransaction((transaction) async{
      transaction.update(docRef, {"endTime": endTime});
    });
  }

  Future<void> createEmptyShowerCollection(User user) async {
    await firebaseProvider.client.collection('timeslots').add({
      'userId': user.id,
      'roomId': user.roomId,
      'startTime': DateTime.now(),
      'endTime': DateTime.now(),
    });
  }
}
