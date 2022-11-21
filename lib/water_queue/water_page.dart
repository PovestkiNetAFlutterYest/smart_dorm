import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_dorm/water_queue/bloc/water_bloc.dart';
import 'package:smart_dorm/water_queue/bloc/water_state.dart';
import 'package:smart_dorm/water_queue/resources/repository.dart';
import 'package:smart_dorm/water_queue/widgets/queue_list.dart';
import 'package:smart_dorm/water_queue/widgets/show_dialog.dart';

import 'bloc/water_event.dart';

class WaterPage extends StatelessWidget {
  final _repository = WaterQueueRepository();

  WaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WaterBloc>(
      create: (context) => WaterBloc(_repository),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Water queue"),
        ),
        body: Center(
            child: BlocBuilder<WaterBloc, WaterState>(
          buildWhen: (prev, curr) {
            if (curr is SuccessfullyRemindPersonState) {
              Future.microtask(() => displayDialog(context));
            }

            return curr is! SuccessfullyRemindPersonState;
          },
          builder: (context, state) {
            WaterBloc bloc = context.read<WaterBloc>();

            if (state is WaterEmptyState) {
              bloc.add(UpdateQueueEvent());
              return const CircularProgressIndicator();
            } else if (state is WaterSuccessState) {
              return const QueueListWidget();
            } else if (state is IsUpdatingState) {
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
