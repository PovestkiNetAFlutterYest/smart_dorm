import 'dart:async';

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
  void dispose() {
    super.dispose();
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
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<DisplayQueueItem>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      itemBuilder: (BuildContext context, int index) {
        ButtonType buttonTypeOfFirstButton = snapshot.data![0].button;
        ButtonType buttonType = snapshot.data![index].button;
        TextButton? button =
            getTextButton(index, snapshot, buttonType, buttonTypeOfFirstButton);

        return ListTile(
            leading: Text(
                format.format(snapshot.data![index].dayWhenNeedToBringWater)),
            title: Text(snapshot.data![index].personToBringWater),
            subtitle: Text(
                "Brang water ${snapshot.data![index].numBottlesBringAlready} times"),
            trailing: button);
      },
    );
  }

  void _showDialog() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('This feature will be added later!'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextButton? getTextButton(
      int index,
      AsyncSnapshot<List<DisplayQueueItem>> snapshot,
      ButtonType buttonType,
      ButtonType typeOfFirstButton) {
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
            _showDialog();
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
        bloc.userBringWater(snapshot.data![index].personIdToBringWater);
      },
      child: const Text('Mark as bring'),
    );
  }
}
