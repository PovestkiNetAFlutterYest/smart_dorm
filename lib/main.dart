import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/auth/auth_page.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/resources/google_signin_repository.dart';
import 'package:smart_dorm/firebase_options.dart';
import 'package:smart_dorm/shower_timetable/shower_page.dart';
import 'package:smart_dorm/water_queue/resources/repository.dart';
import 'package:smart_dorm/water_queue/water_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/bloc/auth_state.dart';
import 'water_queue/bloc/water_bloc.dart';
import 'water_queue/bloc/water_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int _currentPageIndex = 0;

  /// Handler to switch root pages
  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Widget getCurrentWidget() {
    switch (_currentPageIndex) {
      case 0:
        return ShowerPage();
      case 1:
        return const WaterPage();
      default:
        throw Exception("No view found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    SignInRepository signInRepository = SignInRepository();
    WaterQueueRepository waterQueueRepository = WaterQueueRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(signInRepository)),
        BlocProvider(
            create: (context) =>
                WaterBloc(waterQueueRepository)..add(UpdateQueueEvent())),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if ((state is AuthEmptyState || state is LoginFailedState) && false) {
            return const AuthPage();
          } else if (state is LoginSuccessState || true) {
            Widget currentView = getCurrentWidget();
            return Scaffold(
              body: currentView,
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shower_rounded),
                    label: 'Shower',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.water),
                    label: 'Water',
                  ),
                ],
                currentIndex: _currentPageIndex,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              ),
            );
          } else {
            throw Exception("illegal login state");
          }
        },
      ),
    );
  }
}
