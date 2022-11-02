import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_dorm/blocs/generate_queue.dart';

import '../blocs/water_blocs.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  final DateFormat format = DateFormat('dd.MM.yyyy');
  final DateTime now = DateTime.now();

  //Сделал тут StatefulWidget вместо Stateless,
  //чтобы только один раз фтечил данные, а не с каждым билдом
  @override
  void initState() {
    super.initState();
    bloc.fetchAllWater();
  }

  @override
  Widget build(BuildContext context) {
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
          subtitle: Text(
              "Brang water ${snapshot.data![index].numBottlesBringAlready} times"),
          trailing: TextButton(
              onPressed: () {
                bloc.userBringWater(snapshot.data![index].personIdToBringWater);
              },
              child: const Text("Mark as bring")),
        );
      },
    );
  }
}
