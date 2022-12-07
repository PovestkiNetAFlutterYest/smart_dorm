// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dorm/shower_timetable/add_shower_timeslot/bloc/add_shower_slot_bloc.dart';
import 'package:smart_dorm/shower_timetable/add_shower_timeslot/widgets/timeslot_picker.dart';

import '../../auth/resources/local_storage_repository.dart';
import 'bloc/add_shower_slot_event.dart';
import 'bloc/add_shower_slot_state.dart';
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

  _ShowerWidgetState();
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = widget.prefs;
    ShowerSlotsRepository showerSlotsRepository = ShowerSlotsRepository();
    LocalStorageRepository localStorageRepository =
    LocalStorageRepository(prefs!);


    return BlocProvider<AddShowerSlotsBloc>(
        create: (context) => AddShowerSlotsBloc(showerSlotsRepository, localStorageRepository),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Shower timeslots"),
          ),
          body: BlocBuilder<AddShowerSlotsBloc, AddShowerSlotState>(
            builder: (context, state) {
              AddShowerSlotsBloc bloc = context.read<AddShowerSlotsBloc>();
              if (state is AddShowerSlotEmptyState){
                bloc.add(GetShowerSlotForCurrentUser());
              }
              if (state is AddShowerSlotSuccessState) {
                return const TimeSlotPicker();
              }
              return const Center(child: CircularProgressIndicator());
            }
          ),
        ));
  }
}
