import 'dart:async';
import 'package:smart_dorm/auth/models/user.dart';
import 'package:smart_dorm/shower_timetable/dto/shower_timeslot.dart';

import 'firebase_db_provider.dart';

class ShowerSlotsRepository {
  final firebaseProvider = FirebaseProvider();

  Future<List<ShowerTimeSlot>> fetchShowerTimeSlot() =>
      firebaseProvider.getAllShowerTimeSlotData();

  Future<User> getUserById(String userId) =>
      firebaseProvider.getUserById(userId);
}
