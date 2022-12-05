import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_event.dart';

class AboutPage extends StatelessWidget {
  final SharedPreferences prefs;

  const AboutPage(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    String roomId = prefs.getString('roomId')!;
    AuthBloc bloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Row(
        children: [
          Text("Your room id: $roomId"),
          TextButton(
              onPressed: () => bloc.add(LeaveRoomEvent()),
              child: const Text("Leave room"))
        ],
      ),
    );
  }
}
