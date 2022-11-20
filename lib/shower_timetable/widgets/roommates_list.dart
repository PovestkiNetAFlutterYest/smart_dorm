import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/shower_timeslot.dart';

class RoommatesListWidget extends StatelessWidget {
  const RoommatesListWidget(
      {super.key, required this.timeslots, required this.usersNames});
  final List<ShowerTimeSlot> timeslots;
  final List<String> usersNames;

  @override
  Widget build(BuildContext context) {
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
