import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_dorm/auth/models/user.dart';
import 'package:smart_dorm/firebase_options.dart';
import 'package:smart_dorm/pages/shower_page.dart';
import 'package:smart_dorm/water_queue/dto/water_bring_counter.dart';
import 'package:smart_dorm/water_queue/water_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WaterSupplyItemAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<WaterSupplyItem>('water_supply');
  await Hive.openBox<User>("users");
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
        return const ShowerPage();
      case 1:
        return WaterPage();
      default:
        throw Exception("No view found!");
    }
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
