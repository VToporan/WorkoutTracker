import 'dart:convert';
import 'package:GainsTrack/components/modal_component.dart';
import 'package:GainsTrack/components/slidable_componenet.dart';
import 'package:GainsTrack/main.dart';
import 'package:GainsTrack/storage/exercise_data_storage.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../components/card_component.dart';

class Exercises extends StatefulWidget {
  const Exercises({super.key});

  @override
  State<Exercises> createState() => ExercisesState();
}

class ExercisesState extends State<Exercises> {
  late List<ExerciseData> exerciseData;

  @override
  void initState() {
    super.initState();

    exerciseData = HomeState.exerciseData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidableAutoCloseBehavior(
          child: ListView(
        reverse: true,
        children: exerciseData
            .map(
              (currentExercise) => SlidableComponent(
                key: ValueKey(currentExercise.id),
                cardTitle: currentExercise.exerciseName,
                cardSubtitle: computeTime(currentExercise),
                onTap: (() => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ModalComponent(id: currentExercise.id);
                    })),
                onDelete: ((context) {
                  setState(() {
                    exerciseData.remove(currentExercise);
                  });
                }),
              ),
            )
            .toList(),
      )),
    );
  }

  String computeTime(ExerciseData currentExercise) {
    DateTime logDate = lastLogDate(currentExercise);
    return "Last workout ${Jiffy(logDate).fromNow()}";
  }

  DateTime lastLogDate(ExerciseData currentExercise) {
    return currentExercise.logData
        .reduce((value, element) =>
            value.date.compareTo(element.date) > 0 ? value : element)
        .date;
  }
}
