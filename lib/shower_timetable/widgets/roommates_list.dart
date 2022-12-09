import 'package:easy_localization/easy_localization.dart';
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
    late List<String?> usersNames = [];
    late bool isTimeslotsConsistent;
    ShowerSlotsBloc bloc = context.read<ShowerSlotsBloc>();
    ShowerSlotsState state = bloc.state;
    if (state is ShowerSlotsSuccessState) {
      timeslots = state.timeSlotsData;
      isTimeslotsConsistent = state.isConsistent;
      usersNames = state.usersList.map((user) => user?.name).toList();
    }
    const String format = 'HH:mm a';
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: timeslots.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                      title: Text(usersNames[index] ?? 'No data'),
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
            }),
        !isTimeslotsConsistent
            ? Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "inconsistent_time".tr(),
                  style: TextStyle(color: Colors.red.withOpacity(0.8)),
                ),
              )
            : Text(''),
      ],
    );
  }
}
