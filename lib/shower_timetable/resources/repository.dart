import 'dart:async';
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

  Future<void> createEmptyShowerCollection(User user) async {
    await firebaseProvider.client.collection('timeslots').add({
      'userId': user.id,
      'roomId': user.roomId,
      'startTime': DateTime.now(),
      'endTime': DateTime.now(),
    });
  }
}
