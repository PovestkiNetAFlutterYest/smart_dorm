import 'package:cloud_firestore/cloud_firestore.dart';

class WaterSupplyItem {
  String userId;
  int numBottlesBrung;
  Timestamp lastTimeBottleBrung;

  WaterSupplyItem(this.userId, this.numBottlesBrung, this.lastTimeBottleBrung);

  factory WaterSupplyItem.fromJson(Map<String, dynamic> parsedJson) {
    return WaterSupplyItem(parsedJson['userId'], parsedJson['numBottlesBrung'],
        parsedJson['lastTimeBottleBrung']);
  }

  @override
  String toString() {
    return 'WaterSupplyItem{userId: $userId, numBottlesBrung: $numBottlesBrung, lastTimeBottleBrung: $lastTimeBottleBrung}';
  }
}
