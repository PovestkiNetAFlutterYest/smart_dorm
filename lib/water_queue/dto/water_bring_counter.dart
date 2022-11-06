import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'water_bring_counter.g.dart';

// flutter packages pub run build_runner build
@HiveType(typeId: 0)
class WaterSupplyItem extends HiveObject {
  @HiveField(0)
  String userId;
  @HiveField(1)
  int count;
  @HiveField(2)
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
