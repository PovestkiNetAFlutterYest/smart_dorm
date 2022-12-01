class User {
  String id;
  String name;
  String roomId;
  String email;

  User(this.id, this.name, this.roomId, this.email);

  User.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        roomId = parsedJson['roomId'],
        email = parsedJson['email'];


  Map<String, String> toJson() {
    return {
      'id': id,
      'name': name,
      'roomId': roomId,
      'email': email,
    };
  }
}
