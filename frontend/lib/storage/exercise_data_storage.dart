import 'package:intl/intl.dart';

class ExerciseData {
  final int id;
  final String exerciseName;
  final List<LogData> logData;

  ExerciseData({
    required this.id,
    required this.exerciseName,
    required this.logData,
  });

  static ExerciseData fromJson(json) => ExerciseData(
      id: json['id'],
      exerciseName: json['name'],
      logData: json['logData'].map<LogData>(LogData.fromJson).toList());
}

class LogData {
  final int id;
  final double reps;
  final double sets;
  final double weight;
  final String note;
  final DateTime date;

  LogData({
    required this.id,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.note,
    required this.date,
  });

  static LogData fromJson(json) => LogData(
        id: json['id'],
        sets: json['sets'],
        reps: json['reps'],
        weight: json['weight'],
        note: json['note'],
        date: DateFormat('dd.MM.yyyy').parse(json['date']),
      );
}
