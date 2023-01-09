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
        SfCartesianChart(
          plotAreaBorderColor: ThemeColors.backgroundDefault,
          legend: Legend(
            isVisible: true,
            isResponsive: true,
            opacity: 1.0,
            textStyle: Theme.of(context).textTheme.displaySmall,
          ),
          primaryXAxis: CategoryAxis(
            labelStyle: Theme.of(context).textTheme.bodySmall,
            labelRotation: 30,
            majorGridLines: const MajorGridLines(
              width: 1,
              color: ThemeColors.buttonAccent,
            ),
            majorTickLines: const MajorTickLines(
              width: 0,
            ),
          ),
          primaryYAxis: NumericAxis(
            axisLine: const AxisLine(
              width: 2,
              color: ChartColors.weightColor,
            ),
            labelStyle: const TextStyle(
              fontSize: 15,
              color: ChartColors.weightColor,
            ),
            majorGridLines: const MajorGridLines(
              width: 1,
              color: ThemeColors.foregroundAccent,
              dashArray: <double>[1, 1],
            ),
            majorTickLines: const MajorTickLines(
              width: 2,
              color: ChartColors.weightColor,
            ),
          ),
          axes: <ChartAxis>[
            NumericAxis(
              opposedPosition: true,
              name: 'repsAxis',
              labelStyle: const TextStyle(
                fontSize: 15,
                color: ChartColors.repsColor,
              ),
              axisLine: const AxisLine(
                width: 2,
                color: ChartColors.repsColor,
              ),
              majorGridLines: const MajorGridLines(
                width: 2,
                color: ThemeColors.foregroundAccent,
                dashArray: <double>[3, 3],
              ),
              majorTickLines: const MajorTickLines(
                width: 2,
                color: ChartColors.repsColor,
              ),
            ),
            NumericAxis(
              opposedPosition: true,
              name: 'setsAxis',
              labelStyle: const TextStyle(
                fontSize: 15,
                color: ChartColors.setsColor,
              ),
              axisLine: const AxisLine(
                width: 2,
                color: ChartColors.setsColor,
              ),
              majorGridLines: const MajorGridLines(
                width: 1,
                color: ThemeColors.foregroundAccent,
                dashArray: <double>[5, 5],
              ),
              majorTickLines: const MajorTickLines(
                width: 2,
                color: ChartColors.setsColor,
              ),
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
                  formatDate(currentLog.date),
              yValueMapper: (LogData currentLog, _) => currentLog.weight,
            ),
            ColumnSeries<LogData, String>(
              name: 'Reps',
              color: ChartColors.repsColor,
              dataSource: currentExercise.logData,
              xValueMapper: (LogData currentLog, _) =>
                  formatDate(currentLog.date),
              yValueMapper: (LogData currentLog, _) => currentLog.reps,
              yAxisName: 'repsAxis',
            ),
            ColumnSeries<LogData, String>(
              name: 'Sets',
              color: ChartColors.setsColor,
              dataSource: currentExercise.logData,
              xValueMapper: (LogData currentLog, _) =>
                  formatDate(currentLog.date),
              yValueMapper: (LogData currentLog, _) => currentLog.sets,
              yAxisName: 'setsAxis',
            ),
          ],
        ),
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

  String formatDate(DateTime date) {
    return Jiffy(date).format('dd.MMM.yy');
  }
}
