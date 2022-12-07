import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_bloc.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_event.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_state.dart';
import 'package:smart_dorm/shower_timetable/widgets/roommates_list.dart';
import 'package:smart_dorm/shower_timetable/widgets/timeslots_appbar.dart';

class ShowerPage extends StatelessWidget {
  final SharedPreferences prefs;
  const ShowerPage({super.key, required this.prefs});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
            appBar: TimeslotsAppbar(prefs: prefs),
            body: BlocBuilder<ShowerSlotsBloc, ShowerSlotsState>(
              builder: (context, state) {
                ShowerSlotsBloc bloc = context.read<ShowerSlotsBloc>();

                if (state is ShowerSlotsEmptyState) {
                  bloc.add(UpdateShowerSlotsEvent());
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ShowerSlotsSuccessState) {
                  return const RoommatesListWidget();
                }
                return const Text('Unhandled state');
              },
            ));
  }
}
