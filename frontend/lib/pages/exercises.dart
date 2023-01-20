import 'dart:convert';
import 'package:GainsTrack/components/modal_component.dart';
import 'package:GainsTrack/components/slidable_componenet.dart';
import 'package:GainsTrack/main.dart';
import 'package:GainsTrack/storage/exercise_data_storage.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  GlobalKey<ModalComponentState> addKey = GlobalKey();
  InputComponent newExerciseName = InputComponent(
    key: GlobalKey(),
    inputController: TextEditingController(),
    labelText: "Exercise Name",
    isHidden: false,
  );

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
                                    'Add log for ${currentExercise.exerciseName}',
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
                      onDelete: ((context) async {
                        final response = await delete(
                          Uri.parse(
                              'http://localhost:8080/exercises/delete/${currentExercise.id}'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                        );
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
              onTap: (() => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    setAllControllers();
                    return ModalComponent(
                        key: addKey,
                        title: 'Add exercise',
                        inputs: [newExerciseName],
                        onSubmit: () async {
                          SharedPreferences perfs =
                              await SharedPreferences.getInstance();
                          int userid = perfs.getInt("userid") ?? -1;
                          resetError();
                          if (newExerciseName.key.currentState!.isEmpty()) {
                            isError = true;
                          }
                          if (isError) {
                            addKey.currentState!
                                .setErrorMessage("Invalid Inputs");
                            return;
                          }

                          try {
                            final response = await post(
                              Uri.parse(
                                  'http://localhost:8080/exercises/${userid}/add'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                'exercisename':
                                    newExerciseName.inputController.text,
                              }),
                            );

                            if (response.statusCode != StatusCode.OK) {
                              addKey.currentState!
                                  .setErrorMessage("Invalid data");
                              return;
                            }

                            ExerciseData newExercise = ExerciseData.fromJson(
                                json.decode(response.body));

                            setState(() {
                              exerciseData.add(newExercise);
                            });
                          } catch (e) {
                            print(e);
                            addKey.currentState!
                                .setErrorMessage("No connection");
                            return;
                          }
                        });
                  })),
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
