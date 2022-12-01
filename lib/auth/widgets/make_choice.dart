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
        title: const Text("User not found!"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
                "User not found in database, create new room or enter room id"),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () => bloc.add(CreateNewRoomEvent(userLoginInfo)),
              child: const Text("Create room"),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              maxLength: 20
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                bloc.add(JoinRoomEvent(userLoginInfo, controller.text));
                controller.clear();
              },
              child: const Text("Join room"),
            ),
          )
        ],
      ),
    );
  }
}
