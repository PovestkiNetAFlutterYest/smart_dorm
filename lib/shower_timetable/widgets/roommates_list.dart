import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_bloc.dart';
import 'package:smart_dorm/shower_timetable/bloc/shower_slots_state.dart';

import '../dto/shower_timeslot.dart';

class RoommatesListWidget extends StatelessWidget {
  const RoommatesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late List<ShowerTimeSlot> timeslots = [];
    late List<String> usersNames = [];
    ShowerSlotsBloc bloc = context.read<ShowerSlotsBloc>();
    ShowerSlotsState state = bloc.state;
    if (state is ShowerSlotsSuccessState) {
      timeslots = state.timeSlotsData;
      usersNames = state.usersList.map((user) => user.name).toList();
    }
    const String format = 'HH:mm a';
    return ListView.builder(
        itemCount: timeslots.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(
                      usersNames.isNotEmpty ? usersNames[index] : 'No data'),
                  subtitle: Row(
                    children: [
                      Text(DateFormat(format)
                          .format(timeslots[index].startTime.toDate())),
                      const Text(' - '),
                      Text(DateFormat(format)
                          .format(timeslots[index].endTime.toDate())),
                    ],
                  ),
                  leading: CircleAvatar(
                    child: Image.network(
                      "http://kazbas.ilovebasket.ru/team-logo/9723",
                      errorBuilder: (p0, p1, p2) {
                        return Text('error');
                      },
                    ),
                  ),
                  trailing: const Icon(Icons.shower)));
        });
  }
}
