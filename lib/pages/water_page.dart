import 'package:flutter/material.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water queue"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: (){},
              child: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text("Page with water supply", style: optionStyle),
      ),
    );
  }
}
