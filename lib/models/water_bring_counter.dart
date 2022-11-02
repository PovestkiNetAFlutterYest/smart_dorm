import 'package:cloud_firestore/cloud_firestore.dart';

class WaterSupplyItem {
  String userId;
  int numBottlesBrung;
  Timestamp lastTimeBottleBrung;

  WaterSupplyItem(this.userId, this.numBottlesBrung, this.lastTimeBottleBrung);

  WaterSupplyItem.fromJson(Map<String, dynamic> parsedJson)
      : userId = parsedJson['userId'],
        numBottlesBrung = parsedJson['numBottlesBrung'],
        lastTimeBottleBrung = parsedJson['lastTimeBottleBrung'];
}

