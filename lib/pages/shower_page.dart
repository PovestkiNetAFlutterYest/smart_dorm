import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowerPage extends StatelessWidget {
  const ShowerPage({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shower timeslots"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddShowerTimeslotPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "This is shower page",
          style: optionStyle,
        ),
      ),
    );
  }
}

class AddShowerTimeslotPage extends StatefulWidget {
  const AddShowerTimeslotPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShowerWidgetState();
}

class _ShowerWidgetState extends State<AddShowerTimeslotPage> {
  TimeOfDay startSlotTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay endSlotTime = const TimeOfDay(hour: 8, minute: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shower timeslots"),
      ),
      body: const Center(
        child: Text("This is page for choosing timeslot"),
      ),
    );
  }
}
