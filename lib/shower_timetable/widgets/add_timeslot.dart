// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class AddShowerTimeslotPage extends StatefulWidget {
  const AddShowerTimeslotPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShowerWidgetState();
}

class _ShowerWidgetState extends State<AddShowerTimeslotPage> {
  TimeOfDay chosenStartSlotTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay chosenEndSlotTime = const TimeOfDay(hour: 8, minute: 10);

  @override
  Widget build(BuildContext context) {
    handleStartTimeChange() async {
      TimeOfDay? startSlotTime = await showTimePicker(
          context: context, initialTime: chosenStartSlotTime);
      if (startSlotTime == null) return;
      setState(() {
        chosenStartSlotTime = startSlotTime;
      });
    }

    handleEndTimeChange() async {
      TimeOfDay? endSlotTime = await showTimePicker(
          context: context, initialTime: chosenEndSlotTime);
      if (endSlotTime == null) return;
      setState(() {
        chosenEndSlotTime = endSlotTime;
      });
    }

    final startHours = chosenStartSlotTime.hour.toString().padLeft(2, '0');
    final startMinutes = chosenStartSlotTime.minute.toString().padLeft(2, '0');
    final endHours = chosenEndSlotTime.hour.toString().padLeft(2, '0');
    final endMinutes = chosenEndSlotTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shower timeslots"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${startHours}:${startMinutes}-${endHours}:${endMinutes}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          ElevatedButton(
            onPressed: handleStartTimeChange,
            child: const Text('Choose start time'),
          ),
          ElevatedButton(
            onPressed: handleEndTimeChange,
            child: const Text('Choose end time'),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: const Text('Save time'),
          icon: const Icon(Icons.save_outlined),
          backgroundColor: Color.fromARGB(255, 85, 111, 126)),
    );
  }
}
