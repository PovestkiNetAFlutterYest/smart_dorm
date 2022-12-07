import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dorm/auth/auth_page.dart';
import 'package:smart_dorm/auth/bloc/auth_bloc.dart';
import 'package:smart_dorm/auth/resources/google_signin_repository.dart';
import 'package:smart_dorm/auth/resources/local_storage_repository.dart';
import 'package:smart_dorm/firebase_options.dart';
import 'package:smart_dorm/push_notification/local_push_notification.dart';
import 'package:smart_dorm/push_notification/main.dart';
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
  LocalNotificationService.initialize();

  await grantPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: _title,
        theme: theme,
        darkTheme: darkTheme,
        home: const AppHome(),
      ),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int _currentPageIndex = 1;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      print("Message is received!");
      LocalNotificationService.display(event);
    });
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
        return ShowerPage();
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
    LocalStorageRepository localStorageRepository =
        LocalStorageRepository(prefs!);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(signInRepository,
                  localStorageRepository, waterQueueRepository)),
          BlocProvider(
              create: (context) =>
                  WaterBloc(waterQueueRepository, localStorageRepository)),
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
