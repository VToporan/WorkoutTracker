import 'package:GainsTrack/main.dart';
import 'package:GainsTrack/storage/exercise_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/modal_component.dart';
import '../components/slidable_componenet.dart';

class ChartColors {
  static const Color weightColor = Color(0xFFC00060);
  static const Color repsColor = Color(0xFFC000A0);
  static const Color setsColor = Color(0xFFC000D0);
}

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
        SlidableAutoCloseBehavior(
          child: Column(
            children: currentExercise.logData
                .map(
                  (currentLog) => SlidableComponent(
                    key: ValueKey(currentLog.id),
                    cardTitle: currentLog.note,
                    cardSubtitle: Jiffy(currentLog.date).format('MMMM do yyyy'),
                    onTap: (() => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container();
                        })),
                    onDelete: ((context) {
                      setState(() {
                        currentExercise.logData.remove(currentLog);
                      });
                    }),
                  ),
                )
                .toList(),
          ),
        ),
      ]),
    );
  }

  String formatDate(DateTime date) {
    return Jiffy(date).format('dd.MMM.yy');
  }
}
