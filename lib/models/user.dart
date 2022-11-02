class User {
  String userId;
  String name;
  String roomId;
  String telegram;

  User(this.userId, this.name, this.roomId, this.telegram);

  User.fromJson(Map<String, dynamic> parsedJson)
      : userId = parsedJson['userId'],
        name = parsedJson['name'],
        roomId = parsedJson['roomId'],
        telegram = parsedJson['telegram'];
}
