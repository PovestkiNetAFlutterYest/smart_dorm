import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dorm/auth/auth_page.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/resources/google_signin_repository.dart';
import 'package:smart_dorm/auth/resources/local_storage_repository.dart';
import 'package:smart_dorm/firebase_options.dart';
import 'package:smart_dorm/shower_timetable/add_shower_timeslot/bloc/add_shower_slot_bloc.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_bloc.dart';
import 'package:smart_dorm/shower_timetable/resources/repository.dart';
import 'package:smart_dorm/shower_timetable/shower_page.dart';
import 'package:smart_dorm/water_queue/resources/repository.dart';
import 'package:smart_dorm/water_queue/water_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'about/about_page.dart';
import 'auth/bloc/auth_state.dart';
import 'water_queue/bloc/water_bloc.dart';

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
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  /// Handler to switch root pages
  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Widget getCurrentWidget() {
    switch (_currentPageIndex) {
      case 0:
        return ShowerPage(prefs: prefs!);
      case 1:
        return const WaterPage();
      case 2:
        return AboutPage(prefs!);
      default:
        throw Exception("No view found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (prefs == null) {
      // waiting until SharedPreferences will be initialised
      return const CircularProgressIndicator();
    }

    SignInRepository signInRepository = SignInRepository();
    WaterQueueRepository waterQueueRepository = WaterQueueRepository();
    ShowerSlotsRepository showerSlotsRepository = ShowerSlotsRepository();
    LocalStorageRepository localStorageRepository =
        LocalStorageRepository(prefs!);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(signInRepository,
                  localStorageRepository, waterQueueRepository, showerSlotsRepository)),
          BlocProvider(
              create: (context) =>
                  WaterBloc(waterQueueRepository, localStorageRepository)),
          BlocProvider(
              create: (context) =>
                  ShowerSlotsBloc(showerSlotsRepository, localStorageRepository)),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is ShowMainPageState) {
            return showMainPage();
          } else {
            return const AuthPage();
          }
        }));
  }

  void getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      this.prefs = prefs;
    });
  }

  showMainPage() {
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home')
        ],
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
