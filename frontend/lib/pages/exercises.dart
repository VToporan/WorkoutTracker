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
import '../components/input_components.dart';

class Exercises extends StatefulWidget {
  const Exercises({super.key});

  @override
  State<Exercises> createState() => ExercisesState();
}

class ExercisesState extends State<Exercises> {
  late List<ExerciseData> exerciseData;

  late NumberInputComponent setsInput;
  late NumberInputComponent repsInput;
  late NumberInputComponent weightInput;
  late LongInputComponent notesInput;
  late DateInputComponent dateInput;

  late List<InputComponent> inputs;

  bool isError = false;
  GlobalKey<ModalComponentState> modalKey = GlobalKey();

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
          children: [
            Column(
              children: exerciseData
                  .map(
                    (currentExercise) => SlidableComponent(
                      key: ValueKey(currentExercise.id),
                      cardTitle: currentExercise.exerciseName,
                      cardSubtitle: computeTime(currentExercise),
                      onTap: (() => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            setAllControllers();
                            return ModalComponent(
                                key: modalKey,
                                title:
                                    'Add log for - ${currentExercise.exerciseName}',
                                inputs: inputs,
                                onSubmit: () {
                                  resetError();
                                  verifyInputsNotEmpty();
                                  if (isError) {
                                    modalKey.currentState!
                                        .setErrorMessage("Invalid Inputs");
                                  }
                                  print(currentExercise.exerciseName);
                                });
                          })),
                      onDelete: ((context) {
                        setState(() {
                          exerciseData.remove(currentExercise);
                        });
                      }),
                    ),
                  )
                  .toList(),
            ),
            CardComponent(
              title: 'Add new exercise',
              subTitle: '',
              onTap: () {},
            ),
          ],
        ),
      ),
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

  void setAllControllers() {
    setsInput = NumberInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController: TextEditingController(),
      labelText: "Sets",
    );

    repsInput = NumberInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController: TextEditingController(),
      labelText: "Reps",
    );
    weightInput = NumberInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController: TextEditingController(),
      labelText: "Weight",
    );
    notesInput = LongInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController: TextEditingController(),
      labelText: "Notes",
    );

    dateInput = DateInputComponent(
        key: GlobalKey<InputComponentState>(),
        inputController: TextEditingController(),
        labelText: "Date");

    inputs = [
      setsInput,
      repsInput,
      weightInput,
      notesInput,
      dateInput,
    ];
  }

  void verifyInputsNotEmpty() {
    for (InputComponent input in inputs) {
      if (input is! LongInputComponent) {
        if (input.key.currentState!.isEmpty()) {
          setState(() {
            isError = true;
          });
        }
      }
    }
  }

  void resetError() {
    setState(() {
      isError = false;
    });
  }
}
