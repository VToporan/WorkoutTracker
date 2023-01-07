import 'package:GainsTrack/main.dart';
import 'package:GainsTrack/storage/exercise_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends State<History> {
  List<ExerciseData> exerciseData = HomeState.exerciseData;
  ExerciseData currentExercise = HomeState.exerciseData.elementAt(0);

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
      ),
      SfCartesianChart(
          borderWidth: 5,
          primaryXAxis: CategoryAxis(),
          legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<LogData, String>>[
            SplineSeries<LogData, String>(
              width: 5,
              color: Theme.of(context).errorColor,
              dataSource: currentExercise.logData,
              xValueMapper: (LogData currentLog, _) =>
                  DateFormat('dd.MM.yyyy').format(currentLog.date),
              yValueMapper: (LogData currentLog, _) => currentLog.weight,
              name: 'Weight',
            ),
          ]),
      SfCartesianChart(
          borderWidth: 5,
          primaryXAxis: CategoryAxis(),
          legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<LogData, String>>[
            SplineSeries<LogData, String>(
              width: 5,
              color: Theme.of(context).errorColor,
              dataSource: currentExercise.logData,
              xValueMapper: (LogData currentLog, _) =>
                  DateFormat('dd.MM.yyyy').format(currentLog.date),
              yValueMapper: (LogData currentLog, _) => currentLog.sets,
              name: 'Sets',
            ),
          ]),
    ]));
  }
}
