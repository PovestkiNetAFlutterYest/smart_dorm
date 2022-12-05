import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';

import '../bloc/auth_state.dart';

class RoomCreatedPage extends StatelessWidget {
  const RoomCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = context.read<AuthBloc>();
    String roomId = (bloc.state as RoomCreatedState).user.roomId;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Room created"),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                  "Room is successfully created, your room id is $roomId. Use it to invite new users!"),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextButton(
                onPressed: () => bloc.add(ShowMainPageEvent()),
                child: const Text("Main page"),
              ),
            )
          ],
        ));
  }
}
