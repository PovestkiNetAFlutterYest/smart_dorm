import 'package:flutter/material.dart';

void displayDialog(context) {
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
