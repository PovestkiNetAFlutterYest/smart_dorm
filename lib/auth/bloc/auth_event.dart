import 'package:smart_dorm/auth/dto/user_login_info.dart';

class AuthEvent {}

class SignInEvent extends AuthEvent {}

class CreateNewRoomEvent extends AuthEvent {
  UserLoginInfo userLoginInfo;

  CreateNewRoomEvent(this.userLoginInfo);
}

class JoinRoomEvent extends AuthEvent {
  UserLoginInfo userLoginInfo;
  String roomId;

  JoinRoomEvent(this.userLoginInfo, this.roomId);
}

class ShowMainPageEvent extends AuthEvent {}

class LeaveRoomEvent extends AuthEvent {}
