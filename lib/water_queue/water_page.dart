import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:smart_dorm/water_queue/bloc/water_bloc.dart';
import 'package:smart_dorm/water_queue/bloc/water_state.dart';
import 'package:smart_dorm/water_queue/resources/hive_storage.dart';
import 'package:smart_dorm/water_queue/resources/repository.dart';
import 'package:smart_dorm/water_queue/widgets/queue_list.dart';
import 'package:smart_dorm/water_queue/widgets/show_dialog.dart';

import 'bloc/water_event.dart';


class WaterPage extends StatelessWidget {
  final _repository = WaterQueueRepository();
  final _hiveStorage = HiveStorage(
      waterBox: Hive.box("water_supply"), userBox: Hive.box("users"));

  WaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WaterBloc>(
      create: (context) => WaterBloc(_repository, _hiveStorage),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Water queue"),
        ),
        body: Center(child: BlocBuilder<WaterBloc, WaterState>(
          // buildWhen: (prev, curr) => curr is! WaterFailedState,
          builder: (context, state) {
            WaterBloc bloc = context.read<WaterBloc>();

            if (state is SuccessfullyRemindPersonState) {
              Future.microtask(() => displayDialog(context));
            }

            if (state is WaterEmptyState) {
              bloc.add(UpdateQueueEvent());
              return const CircularProgressIndicator();
            } else if (state is WaterSuccessState) {
              return const QueueListWidget();
            } else {
              return Text("Unhandled state: $state");
            }
          },
        )),
      ),
    );
  }
}
