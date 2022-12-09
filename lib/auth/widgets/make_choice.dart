import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';
import 'package:smart_dorm/auth/bloc/auth_state.dart';
import 'package:smart_dorm/auth/dto/user_login_info.dart';

class MakeChoicePage extends StatelessWidget {
  final controller = TextEditingController();

  MakeChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = context.read<AuthBloc>();

    UserLoginInfo userLoginInfo = (bloc.state as MakeChoiceState).userLoginInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text("user_not_found".tr()),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Text("make_choice".tr()),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () => bloc.add(CreateNewRoomEvent(userLoginInfo)),
              child: Text("create_room".tr()),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(controller: controller, maxLength: 20),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                bloc.add(JoinRoomEvent(userLoginInfo, controller.text));
                controller.clear();
              },
              child: Text("join_room".tr()),
            ),
          )
        ],
      ),
    );
  }
}
