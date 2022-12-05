import 'package:shared_preferences/shared_preferences.dart';
import '../dto/user.dart';

class NoCurrentUserException {}

class LocalStorageRepository {
  final SharedPreferences _preferences;

  LocalStorageRepository(this._preferences);

  bool isAlreadyBelongsToRoom() {
    bool? flag = _preferences.getBool("isInRoom");

    if (flag == null || flag == false) {
      return false;
    } else {
      return true;
    }
  }

  User getCurrentUser() {
    String? name = _preferences.getString("name");
    String? email = _preferences.getString('email');
    String? id = _preferences.getString("id");
    String? roomId = _preferences.getString("roomId");

    if (name == null || email == null || id == null || roomId == null) {
      throw NoCurrentUserException();
    }

    return User(id, name, roomId, email);
  }

  Future<void> clearCurrentUser() async {
    print("cleaned user");
    await Future.wait([
      _preferences.remove("name"),
      _preferences.remove("email"),
      _preferences.remove("id"),
      _preferences.remove("roomId")
    ]);
  }

  Future<void> setCurrentUser(User user) async {
    print("set user $user");
    await Future.wait([
      _preferences.setString('name', user.name),
      _preferences.setString('email', user.email),
      _preferences.setString("id", user.id),
      _preferences.setString("roomId", user.roomId)
    ]);
  }
}
