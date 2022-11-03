import 'dart:async';
import 'package:smart_dorm/models/water_bring_counter.dart';

import '../models/shower_timeslot.dart';
import '../models/user.dart';
import 'firebase_db_provider.dart';

class Repository {
  final firebaseProvider = FirebaseProvider();

  Future<List<WaterSupplyItem>?> fetchWaterCount() =>
      firebaseProvider.getAllWaterData();

  Future<List<ShowerTimeSlot>> fetchShowerTimeSlot() =>
      firebaseProvider.getAllShowerTimeSlotData();

  Future<List<User>?> fetchAllUsers() => firebaseProvider.getAllUsers();

  Future<void> incrementNumberWater(String userId) =>
      firebaseProvider.incrementBring(userId);

  Future<User> getUserById(String userId) =>
      firebaseProvider.getUserById(userId);
}
