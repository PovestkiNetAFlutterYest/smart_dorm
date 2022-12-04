import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_dorm/water_queue/bloc/water_bloc.dart';
import 'package:smart_dorm/water_queue/bloc/water_event.dart';
import 'package:smart_dorm/water_queue/bloc/water_state.dart';

import '../dto/queue_item.dart';

class QueueListWidget extends StatelessWidget {
  const QueueListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('dd.MM.yyyy');

    return BlocBuilder<WaterBloc, WaterState>(
        buildWhen: (prev, curr) => curr is! SuccessfullyRemindPersonState,
        builder: (context, state) {
          List<DisplayQueueItem> items = [];
          if (state is WaterSuccessState) {
            items = state.data;
          } else {
            items = [];
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              ButtonType buttonTypeOfFirstButton = items[0].button;
              ButtonType buttonType = items[index].button;
              TextButton? button = getTextButton(
                  context, index, items, buttonType, buttonTypeOfFirstButton);

              DateTime dateToBringWater = items[index].dayWhenNeedToBringWater;
              String name = items[index].personToBringWater;
              int count = items[index].numBottlesBringAlready;

              return ListTile(
                  leading: Text(format.format(dateToBringWater)),
                  title: Text(name),
                  subtitle: Text("Bring water $count times"),
                  trailing: button);
            },
          );
        });
  }
}

TextButton? getTextButton(
    BuildContext context,
    int index,
    List<DisplayQueueItem> items,
    ButtonType buttonType,
    ButtonType typeOfFirstButton) {
  String userId = items[index].personIdToBringWater;
  WaterBloc bloc = context.read<WaterBloc>();

  if (buttonType == ButtonType.remindToBringWater) {
    if (index == 0 ||
        (index == 1 && typeOfFirstButton == ButtonType.bringWater)) {
      return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(8.0),
          textStyle: const TextStyle(fontSize: 10),
          backgroundColor: Colors.red,
        ),
        onPressed: () {
          bloc.add(RemindBringWaterEvent(userId: userId));
        },
        child: const Text('Remind person'),
      );
    } else {
      return null;
    }
  }

  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(8.0),
      textStyle: const TextStyle(fontSize: 10),
      backgroundColor: Colors.blue,
    ),
    onPressed: () {
      bloc.add(IncrementWaterCountEvent(userId: userId, previousData: items));
    },
    child: const Text('Mark as bring'),
  );
}
