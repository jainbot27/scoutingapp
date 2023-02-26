import 'package:flutter/material.dart';

import 'package:scoutingapp/logic/HomeScreen/new_data.dart';
import 'package:scoutingapp/logic/HomeScreen/push_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Spartabots 2023 Scouting App"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage('assets/spartabotsLogo.png')),
            TextButton(
                onPressed: () => newData(context),
                child: const Text("Create New Scouting Data")),
            TextButton(
                onPressed: () => pushData(context),
                child: const Text("Upload Data Stored on Device")),
          ],
        )));
  }
}
