import 'package:easy_localization/easy_localization.dart';
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
          title: Text("room_created".tr()),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text("room_created_success".tr(args: [roomId])),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextButton(
                onPressed: () => bloc.add(ShowMainPageEvent()),
                child: Text("main_page".tr()),
              ),
            )
          ],
        ));
  }
}
