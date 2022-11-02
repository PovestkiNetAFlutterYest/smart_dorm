import 'dart:async';
import 'package:smart_dorm/models/water_bring_counter.dart';

import '../models/user.dart';
import 'firebase_db_provider.dart';

class Repository {
  final firebaseProvider = FirebaseProvider();

  Future<List<WaterSupplyItem>> fetchWaterCount() =>
      firebaseProvider.getAllWaterData();

  Future<List<User>> fetchAllUsers() =>
    firebaseProvider.getAllUsers();
}
