import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/bloc/auth_state.dart';
import 'package:smart_dorm/auth/widgets/is_already_attached_to_room.page.dart';
import 'package:smart_dorm/auth/widgets/make_choice.dart';
import 'package:smart_dorm/auth/widgets/room_created.dart';
import 'package:smart_dorm/auth/widgets/signin_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(buildWhen: (prev, curr) {
      if (curr is EnteredRoomIdDoNotExists) {
        Future.microtask(() => showRoomNotExist(context));
      }

      return curr is! EnteredRoomIdDoNotExists;
    }, builder: (context, state) {
      if (state is AuthInitialState) {
        return const SignInPage();
      }

      if (state is RoomCreatedState) {
        return const RoomCreatedPage();
      }

      if (state is AlreadyAttachedToRoom) {
        return const IsAttachedToRoomPage();
      }

      if (state is MakeChoiceState) {
        return MakeChoicePage();
      }

      FirebaseCrashlytics.instance.recordError(
          "",
          null,
          reason: "Unhandled state (in auth): $state"
      );
      throw Exception("Unhandled state (in auth): $state");
    });
  }
}

void showRoomNotExist(context) {
  showDialog(
    context: context, barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('This room id is invalid, try again!'),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
