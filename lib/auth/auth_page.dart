import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = context.read<AuthBloc>();
    return Scaffold(
      body: Center(
        child: FloatingActionButton.extended(
            onPressed: () {
              bloc.add(LoginButtonPressedEvent());
            },
            label: const Text("Sign in with Google"),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            icon: Image.asset(
              'assets/launch_icon/google_icon.png',
              height: 32,
              width: 32,
            )),
      ),
    );
  }
}
