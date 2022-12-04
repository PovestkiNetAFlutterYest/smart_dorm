import 'package:smart_dorm/auth/dto/user_login_info.dart';

import '../dto/user.dart';

class AuthState {}

// will redirect to screen with login button
class AuthInitialState extends AuthState {
  String? message;

  AuthInitialState({this.message});
}

class RoomCreatedState extends AuthState {
  User user;

  RoomCreatedState(this.user);
}

class MakeChoiceState extends AuthState {
  UserLoginInfo userLoginInfo;

  MakeChoiceState(this.userLoginInfo);
}

class AlreadyAttachedToRoom extends AuthState {
  // add name of neighbors in the room and room id

  User user;

  AlreadyAttachedToRoom(this.user);
}

class EnteredRoomIdDoNotExists extends AuthState {}

class ShowMainPageState extends AuthState {}

class AuthFailedState extends AuthState {}
