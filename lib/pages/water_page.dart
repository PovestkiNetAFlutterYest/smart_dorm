import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaterPage extends StatelessWidget {
  WaterPage({super.key});

  final DateFormat format = DateFormat('dd.MM.yyyy');
  final DateTime now = DateTime.now();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water queue"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
      ),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            leading: Text(format.format(now)),
            title: const Text("Grisha Kostarev"),
            trailing: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {},
              child: const Text('Remind'),
            ),
          ),
          ListTile(
            leading: Text(format.format(now)),
            title: const Text("Shamil Arslanov"),
            trailing: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {},
              child: const Text('Mark me'),
            ),
          )
        ],
      )),
    );
  }
}
