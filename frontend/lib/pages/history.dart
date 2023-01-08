import 'package:GainsTrack/components/card_component.dart';
import 'package:GainsTrack/main.dart';
import 'package:GainsTrack/storage/exercise_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
  late List<Widget> cardList;

  @override
  void initState() {
    exerciseData = HomeState.exerciseData;
    currentExercise = exerciseData.elementAt(0);
    cardList = mapLogsToCards(currentExercise);
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
              cardList = mapLogsToCards(currentExercise);
            });
          },
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
        Column(
          children: cardList,
        ),
      ]),
    );
  }

  List<Widget> mapLogsToCards(ExerciseData currentExercise) {
    return currentExercise.logData
        .map((log) => CardComponent(
            id: log.id,
            title: DateFormat('dd-MMM-yy').format(log.date),
            subTitle: log.note))
        .toList();
  }
}
