import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_dorm/shower_timetable/add_shower_timeslot/bloc/add_shower_slot_bloc.dart';
import 'package:smart_dorm/shower_timetable/add_shower_timeslot/bloc/add_shower_slot_state.dart';

import '../../dto/shower_timeslot.dart';
import '../bloc/add_shower_slot_event.dart';

class TimeSlotPicker extends StatelessWidget {
  const TimeSlotPicker({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    late ShowerTimeSlot timeSlot;
    late String startHours;
    late String startMinutes;
    late String endHours;
    late String endMinutes;
    late Function handleStartTimeChange;
    late Function handleEndTimeChange;
    // late DateTime endTime;
    AddShowerSlotsBloc bloc = context.read<AddShowerSlotsBloc>();
    AddShowerSlotState state = bloc.state;
    if (state is AddShowerSlotSuccessState) {
      timeSlot = state.timeSlotData;
      var startTime = DateTime.fromMicrosecondsSinceEpoch(
          timeSlot.startTime.microsecondsSinceEpoch);
      var endTime = DateTime.fromMicrosecondsSinceEpoch(
          timeSlot.endTime.microsecondsSinceEpoch);

      startHours = startTime.hour.toString().padLeft(2, '0');
      startMinutes = startTime.minute.toString().padLeft(2, '0');
      endHours = endTime.hour.toString().padLeft(2, '0');
      endMinutes = endTime.minute.toString().padLeft(2, '0');

      handleStartTimeChange = () async {
        TimeOfDay? startSlotTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.fromDateTime(startTime));
        if (startSlotTime == null) return;
        if (endTime.hour * 60 + endTime.minute <
            startSlotTime.hour * 60 + startSlotTime.minute) {
          Fluttertoast.showToast(
              msg: "incorrect_time".tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }
        bloc.add(UpdateStartTime(startTime: startSlotTime));
      };

      handleEndTimeChange = () async {
        TimeOfDay? endSlotTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.fromDateTime(endTime));
        if (endSlotTime == null) return;
        if (endSlotTime.hour * 60 + endSlotTime.minute <
            startTime.hour * 60 + startTime.minute) {
          Fluttertoast.showToast(
              msg: "Incorrect time.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }
        bloc.add(UpdateEndTime(endTime: endSlotTime));
      };
    }
    // const String format = 'HH:mm a';
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$startHours:$startMinutes-$endHours:$endMinutes',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        ElevatedButton(
          onPressed: () => handleStartTimeChange(),
          child: Text("start_time".tr()),
        ),
        ElevatedButton(
          onPressed: () => handleEndTimeChange(),
          child: Text("end_time".tr()),
        )
      ],
    ));
  }
}
