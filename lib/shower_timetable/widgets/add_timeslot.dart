import 'package:flutter/material.dart';

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
