import 'package:adaptive_theme/adaptive_theme.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 10),
            alignment: Alignment.topCenter,
            child: SelectableText(
              "User this room number for inviting: $roomId!",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => bloc.add(LeaveRoomEvent()),
              child: const Text("Leave room (removes all your data)"),
            ),
          ),

          // toggle light/dark theme
          Row(
            children: [
              Expanded(
                  child: TextButton(
                      onPressed: () => AdaptiveTheme.of(context).setDark(),
                      child: const Text("Dark mode"))),
              Expanded(
                child: TextButton(
                  onPressed: () => AdaptiveTheme.of(context).setLight(),
                  child: const Text("Light mode"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
