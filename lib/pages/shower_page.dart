// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_dorm/blocs/generate_queue.dart';
import 'package:smart_dorm/models/shower_timeslot.dart';
import 'package:smart_dorm/models/user.dart';
import 'package:smart_dorm/resources/repository.dart';

class ShowerPage extends StatefulWidget {
  const ShowerPage({super.key});
  @override
  State<ShowerPage> createState() => _ShowerPageState();
}

class _ShowerPageState extends State<ShowerPage> {
  final _repository = Repository();
  late List<ShowerTimeSlot> timeslots = [];
  late List<String> mappedNameData = [];
  late final String format = 'HH:mm a';

  @override
  void initState() {
    super.initState();
    fetchShowerTimeslots();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> fetchShowerTimeslots() async {
    List<ShowerTimeSlot> timeslotsData =
        await _repository.fetchShowerTimeSlot();

    List<Future<User>> mappedNameDataFutures = [];
    timeslotsData.forEach((timeSlot) {
      mappedNameDataFutures.add(_repository.getUserById(timeSlot.userId));
    });

    var mappedNameDataResult = await Future.wait(mappedNameDataFutures);
    print(mappedNameDataResult.map((user) => user.name));

    setState(() {
      timeslots = timeslotsData;
      mappedNameData = mappedNameDataResult.map((user) => user.name).toList();
    });
  }

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
        body: ListView.builder(
            itemCount: timeslots.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                      title: Text(mappedNameData.length > 0
                          ? mappedNameData[index]
                          : 'No data'),
                      subtitle: Row(
                        children: [
                          Text(DateFormat(format)
                              .format(timeslots[index].startTime.toDate())),
                          Text(' - '),
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
                      trailing: Icon(Icons.shower)));
            }));
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
