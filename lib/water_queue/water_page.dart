import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_dorm/water_queue/bloc/water_bloc.dart';
import 'package:smart_dorm/water_queue/bloc/water_state.dart';
import 'package:smart_dorm/water_queue/widgets/queue_list.dart';
import 'package:smart_dorm/water_queue/widgets/show_dialog.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("water_bar".tr()),
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
          if (state is WaterEmptyState) {
            return const CircularProgressIndicator();
          } else {
            return const QueueListWidget();
          }
        },
      )),
    );
  }
}
