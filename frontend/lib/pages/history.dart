import 'package:GainsTrack/components/card_component.dart';
import 'package:GainsTrack/main.dart';
import 'package:GainsTrack/storage/exercise_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../components/modal_component.dart';
import '../components/slidable_componenet.dart';

class ChartColors {
  static const Color weightColor = Color(0xFFC02080);
  static const Color repsColor = Color(0xFF8020C0);
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
        SfCartesianChart(
          legend: Legend(
            isVisible: true,
            isResponsive: true,
            opacity: 1.0,
            textStyle: Theme.of(context).textTheme.displaySmall,
          ),
          primaryXAxis: CategoryAxis(
            labelStyle: Theme.of(context).textTheme.bodySmall,
            labelRotation: 90,
          ),
          primaryYAxis: NumericAxis(),
          axes: <ChartAxis>[
            NumericAxis(
              opposedPosition: true,
              name: 'repsAxis',
            ),
          ],
          tooltipBehavior: TooltipBehavior(
            enable: false,
          ),
          series: <ChartSeries<LogData, String>>[
            ColumnSeries<LogData, String>(
              name: 'Weight',
              color: ChartColors.weightColor,
              dataSource: currentExercise.logData,
              xValueMapper: (LogData currentLog, _) =>
                  DateFormat('dd-MMM-yy').format(currentLog.date),
              yValueMapper: (LogData currentLog, _) => currentLog.weight,
            ),
            ColumnSeries<LogData, String>(
              name: 'Reps',
              color: ChartColors.repsColor,
              dataSource: currentExercise.logData,
              xValueMapper: (LogData currentLog, _) =>
                  DateFormat('dd-MMM-yy').format(currentLog.date),
              yValueMapper: (LogData currentLog, _) => currentLog.reps,
              yAxisName: 'repsAxis',
            ),
          ],
        ),
        SlidableAutoCloseBehavior(
          child: Column(
            children: currentExercise.logData
                .map(
                  (currentLog) => SlidableComponent(
                    key: ValueKey(currentLog.id),
                    cardTitle: currentLog.sets.toString(),
                    cardSubtitle: currentLog.note,
                    onTap: (() => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ModalComponent(id: currentLog.id);
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
}
