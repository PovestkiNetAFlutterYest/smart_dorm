// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_event.dart';

import '../bloc/shower_slots_bloc.dart';
import '../bloc/shower_slots_state.dart';

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

    ShowerSlotsBloc bloc = context.read<ShowerSlotsBloc>();
    ShowerSlotsState state = bloc.state;
    if (state is CurrentShowerSlotSuccessState) {
      // timeslots = state.timeSlotData;
      print(state.timeSlotData);
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Shower timeslots"),
      ),
      body: BlocBuilder<ShowerSlotsBloc, ShowerSlotsState>(
        builder: (context, state) {
          ShowerSlotsBloc bloc = context.read<ShowerSlotsBloc>();

          if (state is ShowerSlotsEmptyState) {
            bloc.add(GetShowerSlotForCurrentUser());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CurrentShowerSlotSuccessState) {
            return
            Center(
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
                ));
          }
          return const Text('Unhandled state');
        },
      ),
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
