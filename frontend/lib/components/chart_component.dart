import 'package:GainsTrack/storage/exercise_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartColors {
  static const Color weightColor = Color(0xFFE550D0);
  static const Color repsColor = Color(0xFFA020C0);
  static const Color setsColor = Color(0xFFD00090);
  static const Color lineColor = Color(0xFFF0D0F0);
}

class ChartComponent extends StatelessWidget {
  final ExerciseData currentExercise;

  const ChartComponent({super.key, required this.currentExercise});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderColor: Theme.of(context).backgroundColor,
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
          color: ChartColors.lineColor,
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
          color: ChartColors.lineColor,
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
            color: ChartColors.lineColor,
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
            color: ChartColors.lineColor,
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
          xValueMapper: (LogData currentLog, _) => formatDate(currentLog.date),
          yValueMapper: (LogData currentLog, _) => currentLog.weight,
        ),
        ColumnSeries<LogData, String>(
          name: 'Reps',
          color: ChartColors.repsColor,
          dataSource: currentExercise.logData,
          xValueMapper: (LogData currentLog, _) => formatDate(currentLog.date),
          yValueMapper: (LogData currentLog, _) => currentLog.reps,
          yAxisName: 'repsAxis',
        ),
        ColumnSeries<LogData, String>(
          name: 'Sets',
          color: ChartColors.setsColor,
          dataSource: currentExercise.logData,
          xValueMapper: (LogData currentLog, _) => formatDate(currentLog.date),
          yValueMapper: (LogData currentLog, _) => currentLog.sets,
          yAxisName: 'setsAxis',
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    return Jiffy(date).format('dd.MMM.yy');
  }
}
