class AuthState {}

class AuthEmptyState extends AuthState {}

class LoginSuccessState extends AuthState {
  String email;

  LoginSuccessState(this.email);
}

class LoginFailedState extends AuthState {}
