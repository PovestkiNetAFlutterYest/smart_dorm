class UserLoginInfo {
  late String name;
  late String email;
  late String id;

  UserLoginInfo(String? name, String? email, String? id) {
    this.name = name ?? "No name";
    this.email = email ?? "No email";
    this.id = id ?? "No id";

  }

  @override
  String toString() {
    return 'UserInfo{name: $name, email: $email, id: $id}';
  }
}
