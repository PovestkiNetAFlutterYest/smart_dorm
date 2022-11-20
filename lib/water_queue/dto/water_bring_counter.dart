import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class WaterSupplyItem extends HiveObject {
  String userId;
  int count;
  Timestamp lastTimeBring;

  WaterSupplyItem(this.userId, this.count, this.lastTimeBring);

  factory WaterSupplyItem.fromJson(Map<String, dynamic> parsedJson) {
    return WaterSupplyItem(parsedJson['userId'], parsedJson['numBottlesBrung'],
        parsedJson['lastTimeBottleBrung']);
  }

  @override
  String toString() {
    return 'WaterSupplyItem{userId: $userId, numBottlesBrung: $count}';
  }
}
