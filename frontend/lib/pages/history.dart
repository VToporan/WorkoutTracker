import 'package:GainsTrack/main.dart';
import 'package:GainsTrack/storage/exercise_data_storage.dart';
import 'package:flutter/material.dart';

import '../components/chart_component.dart';
import '../components/notes_component.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends State<History> {
  late List<ExerciseData> exerciseData;
  late ExerciseData currentExercise;

  @override
  void initState() {
    exerciseData = HomeState.exerciseData;
    currentExercise = exerciseData.elementAt(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        DropdownButton(
          value: currentExercise.id,
          items: exerciseData
              .map<DropdownMenuItem<int>>((exerciseRecord) => DropdownMenuItem(
                    value: exerciseRecord.id,
                    child: Text(exerciseRecord.exerciseName),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              currentExercise =
                  exerciseData.firstWhere((element) => element.id == value);
            });
          },
          dropdownColor: ThemeColors.buttonDefault,
          focusColor: ThemeColors.backgroundDefault,
        ),
        const Divider(
          height: 20,
        ),
        ChartComponent(currentExercise: currentExercise),
        NotesComponent(currentExercise: currentExercise),
      ]),
    );
  }
}
