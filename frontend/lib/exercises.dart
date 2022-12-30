import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

import 'components/card_component.dart';

class Exercises extends StatefulWidget {
  const Exercises({super.key});

  @override
  State<Exercises> createState() => ExercisesState();
}

class ExercisesState extends State<Exercises> {
  List data = extractFromPayload();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        appBar: AppBar(
          title: const Text("GainsTrack"),
          centerTitle: true,
          backgroundColor: Colors.orange[400],
          foregroundColor: Colors.red[900],
        ),
        body: Center(
            child: ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    key: ValueKey(data[index]["id"]),
                    startActionPane: ActionPane(
                      dismissible: DismissiblePane(onDismissed: () {}),
                      motion: const ScrollMotion(),
                      children: const [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          onPressed: null,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: null,
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          icon: Icons.settings,
                          label: 'Settings',
                        ),
                      ],
                    ),
                    child: CardComponent(
                        title: data[index]["title"],
                        subTitle: data[index]["subtitle"]),
                  );
                })));
  }

  static List extractFromPayload() {
    const data =
        '[{ "title": "Title 1", "subtitle": "Subtitle 1", "id": 1},{ "title": "Title 2", "subtitle": "Subtitle 2", "id": 2}]';
    return json.decode(data.toString());
  }
}
