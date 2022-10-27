import 'package:flutter/material.dart';
import 'package:smart_dorm/shower_page.dart';
import 'package:smart_dorm/water_page.dart';

void main() => runApp(const MyApp());

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
  State<AppHome> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<AppHome> {
  int _currentPageIndex = 0;
  List bodies = [
    const ShowerPage(),
    const WaterPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[_currentPageIndex],
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
