import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../add_shower_timeslot/add_timeslot.dart';

class TimeslotsAppbar extends StatelessWidget with PreferredSizeWidget {
  final SharedPreferences prefs;

  const TimeslotsAppbar({super.key, required this.prefs});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("shower_timeslots".tr()),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddShowerTimeslotPage(prefs: prefs);
                    },
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                  Text("edit_my_slot".tr())
                ],
              )),
        )
      ],
    );
  }
}
