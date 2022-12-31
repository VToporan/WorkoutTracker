import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

import '../components/card_component.dart';

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
        body: SlidableAutoCloseBehavior(
            child: ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  var currentCard = data[index];
                  return Slidable(
                    key: ValueKey(currentCard["id"]),
                    groupTag: "0",
                    startActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          flex: 1,
                          onPressed: (context) {
                            setState(() {
                              data.remove(currentCard);
                            });
                          },
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
                        title: currentCard["title"],
                        subTitle: currentCard["subtitle"]),
                  );
                })));
  }

  static List extractFromPayload() {
    const data =
        '[{ "title": "Title 1", "subtitle": "Subtitle 1", "id": 1},{ "title": "Title 2", "subtitle": "Subtitle 2", "id": 2}]';
    return json.decode(data.toString());
  }
}
