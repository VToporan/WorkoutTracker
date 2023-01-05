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
  List<CardComponent> cards = extractFromPayload();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidableAutoCloseBehavior(
        child: ListView.builder(
            reverse: true,
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              var currentCard = cards[index];
              return Slidable(
                  key: ValueKey(currentCard.id),
                  groupTag: "0",
                  startActionPane: ActionPane(
                    motion: const BehindMotion(),
                    extentRatio: 0.25,
                    openThreshold: 0.15,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            cards.remove(currentCard);
                          });
                        },
                        backgroundColor: Theme.of(context).errorColor,
                        foregroundColor: Theme.of(context).primaryColor,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: currentCard);
            }),
      ),
    );
  }

  static List<CardComponent> extractFromPayload() {
    const data = [
      {"title": "Bench press", "subtitle": "Last edited: 3 days ago", "id": 1},
      {"title": "Biceps curls", "subtitle": "Last edited: 4 weeks ago", "id": 2}
    ];
    return data.map<CardComponent>(CardComponent.fromJson).toList();
  }
}
