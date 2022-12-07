// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dorm/shower_timetable/add_shower_timeslot/bloc/add_shower_slot_bloc.dart';

import '../../auth/resources/local_storage_repository.dart';
import '../resources/repository.dart';

class AddShowerTimeslotPage extends StatefulWidget {
  final SharedPreferences prefs;
  const AddShowerTimeslotPage({super.key, required this.prefs});

  @override
  State<StatefulWidget> createState() => _ShowerWidgetState();
}

class _ShowerWidgetState extends State<AddShowerTimeslotPage> {
  TimeOfDay chosenStartSlotTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay chosenEndSlotTime = const TimeOfDay(hour: 8, minute: 10);
  // ShowerSlotsRepository showerSlotsRepository = ShowerSlotsRepository();
  // LocalStorageRepository localStorageRepository =
  // LocalStorageRepository(prefs);

  _ShowerWidgetState();
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = widget.prefs;

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
    ShowerSlotsRepository showerSlotsRepository = ShowerSlotsRepository();
    LocalStorageRepository localStorageRepository =
    LocalStorageRepository(prefs!);

    final startHours = chosenStartSlotTime.hour.toString().padLeft(2, '0');
    final startMinutes = chosenStartSlotTime.minute.toString().padLeft(2, '0');
    final endHours = chosenEndSlotTime.hour.toString().padLeft(2, '0');
    final endMinutes = chosenEndSlotTime.minute.toString().padLeft(2, '0');
    //TODO local repo add
    return BlocProvider<AddShowerSlotsBloc>(
        create: (context) => AddShowerSlotsBloc(showerSlotsRepository, localStorageRepository),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Shower timeslots"),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${startHours}:${startMinutes}-${endHours}:${endMinutes}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
        ));
  }
}
