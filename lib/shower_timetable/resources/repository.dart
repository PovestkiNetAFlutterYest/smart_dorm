import 'dart:async';
import 'package:smart_dorm/auth/models/user.dart';
import 'package:smart_dorm/models/shower_timeslot.dart';

import 'firebase_db_provider.dart';

class Repository {
  final firebaseProvider = FirebaseProvider();

  Future<List<ShowerTimeSlot>> fetchShowerTimeSlot() =>
      firebaseProvider.getAllShowerTimeSlotData();

  Future<User> getUserById(String userId) =>
      firebaseProvider.getUserById(userId);
}
