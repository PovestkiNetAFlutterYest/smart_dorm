import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void displayDialog(context) {
  showDialog(
    context: context, barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text("send_notification_sign".tr()),
        actions: [
          TextButton(
            child:  Text('Ok'.tr()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
