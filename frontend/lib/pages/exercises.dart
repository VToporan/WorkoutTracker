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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidableAutoCloseBehavior(
        child: ListView.builder(
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return Container();
            }),
      ),
    );
  }
}
