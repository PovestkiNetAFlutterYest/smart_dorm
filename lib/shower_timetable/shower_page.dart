import 'package:flutter/material.dart';
import 'package:smart_dorm/shower_timetable/dto/shower_timeslot.dart';
import 'package:smart_dorm/auth/models/user.dart';
import 'package:smart_dorm/shower_timetable/resources/repository.dart';
import 'package:smart_dorm/shower_timetable/widgets/roommates_list.dart';
import 'package:smart_dorm/shower_timetable/widgets/timeslots_appbar.dart';

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
    for (var timeSlot in timeslotsData) {
      mappedNameDataFutures.add(_repository.getUserById(timeSlot.userId));
    }

    var mappedNameDataResult = await Future.wait(mappedNameDataFutures);

    setState(() {
      timeslots = timeslotsData;
      mappedNamesData = mappedNameDataResult.map((user) => user.name).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TimeslotsAppbar(),
        body: RoommatesListWidget(
          timeslots: timeslots,
          usersNames: mappedNamesData,
        ));
  }
}
