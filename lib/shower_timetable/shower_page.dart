import 'package:flutter/material.dart';
import 'package:smart_dorm/models/shower_timeslot.dart';
import 'package:smart_dorm/auth/models/user.dart';
import 'package:smart_dorm/resources/repository.dart';
import 'package:smart_dorm/shower_timetable/widgets/roommates_list.dart';

class ShowerPage extends StatefulWidget {
  const ShowerPage({super.key});

  @override
  State<ShowerPage> createState() => _ShowerPageState();
}

class _ShowerPageState extends State<ShowerPage> {
  final _repository = Repository();
  late List<ShowerTimeSlot> timeslots = [];
  late List<String> mappedNamesData = [];

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

    setState(() {
      timeslots = timeslotsData;
      mappedNamesData = mappedNameDataResult.map((user) => user.name).toList();
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
        body: RoommatesListWidget(
          timeslots: timeslots,
          usersNames: mappedNamesData,
        ));
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
