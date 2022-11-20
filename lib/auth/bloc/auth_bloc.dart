import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';
import 'package:smart_dorm/auth/bloc/auth_state.dart';

import '../resources/google_signin_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInRepository repository;

  AuthBloc(this.repository) : super(AuthEmptyState()) {
    on<LoginButtonPressedEvent>((event, emit) async {
      try {
        String? email = await repository.login();
        if (email != null) {
          emit(LoginSuccessState(email));
        } else {
          emit(LoginFailedState());
        }
      } on Exception catch (e) {
        if (kDebugMode) {
          print("Exception at LoginButtonPressedEvent: $e");
        }
        emit(LoginFailedState());
      }
    });
  }
}
