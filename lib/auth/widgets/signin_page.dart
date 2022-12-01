import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter into room"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(
                top: 100, right: 20, left: 20, bottom: 50),
            child: const Text("Login using google"),
          ),
          Container(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                onPressed: () => bloc.add(SignInEvent()),
                icon: Image.asset(
                  'assets/launch_icon/google_icon.png',
                  height: 32,
                  width: 32,
                ),
                label: const Text("Sign in!"),
              )),
        ],
      ),
    );
  }
}
