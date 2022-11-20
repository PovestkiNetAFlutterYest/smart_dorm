
import 'package:hive/hive.dart';

part 'user.g.dart';

// flutter packages pub run build_runner build
@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String roomId;
  @HiveField(3)
  String telegram;

  User(this.userId, this.name, this.roomId, this.telegram);

  User.fromJson(Map<String, dynamic> parsedJson)
      : userId = parsedJson['userId'],
        name = parsedJson['name'],
        roomId = parsedJson['roomId'],
        telegram = parsedJson['telegram'];
}
