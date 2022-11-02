import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_dorm/blocs/generate_queue.dart';

import '../blocs/water_blocs.dart';

class WaterPage extends StatelessWidget {
  WaterPage({super.key});

  final DateFormat format = DateFormat('dd.MM.yyyy');
  final DateTime now = DateTime.now();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllWater();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water queue"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: bloc.allWater,
            builder: (context, AsyncSnapshot<List<DisplayQueueItem>> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              } else {
                return Text(snapshot.error.toString());
              }
            }),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<DisplayQueueItem>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: Text(
                format.format(snapshot.data![index].dayWhenNeedToBringWater)),
            title: Text(snapshot.data![index].personToBringWater),
            trailing: Text(snapshot.data![index].personIdToBringWater));
      },
    );
  }
}
