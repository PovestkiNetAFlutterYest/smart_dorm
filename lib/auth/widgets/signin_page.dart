import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';

class SignInPage extends StatelessWidget {
  final String? message;

  const SignInPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("enter_into_room".tr()),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(
                top: 100, right: 20, left: 20, bottom: 50),
            child: Text("login_using_google".tr()),
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
                label: Text("sign_in".tr()),
              )),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(message ?? ""),
          )
        ],
      ),
    );
  }
}
