import 'package:flutter/material.dart';

import 'add_timeslot.dart';

class TimeslotsAppbar extends StatelessWidget with PreferredSizeWidget {
  const TimeslotsAppbar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Shower timeslots"),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddShowerTimeslotPage(),
                ),
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        )
      ],
    );
  }
}
