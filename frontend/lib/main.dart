import 'dart:math';

import 'package:GainsTrack/storage/user_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/modal_component.dart';
import 'pages/exercises.dart';
import 'pages/history.dart';
import 'pages/authentication.dart';
import 'storage/exercise_data_storage.dart';

class ThemeColors {
  ThemeColors._();

  static const Color buttonDefault = Color(0xFF302030);
  static const Color buttonAccent = Color(0xFF908090);
  static const Color foregroundDefault = Color(0xFF605560);
  static const Color foregroundAccent = Color(0xFFAA99AA);
  static const Color backgroundDefault = Color(0xFF100010);
  static const Color backgroundAccent = Color(0xFF1A0A1A);
  static const Color errorDefault = Color(0xFFD03070);
}

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MaterialApp(
      title: "Workout Tracker",
      theme: ThemeData(
        primaryColor: ThemeColors.foregroundAccent,
        backgroundColor: ThemeColors.backgroundDefault,
        scaffoldBackgroundColor: ThemeColors.backgroundDefault,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: ThemeColors.backgroundAccent,
            selectedItemColor: ThemeColors.foregroundAccent,
            unselectedItemColor: ThemeColors.foregroundDefault),
        appBarTheme: const AppBarTheme(
          backgroundColor: ThemeColors.backgroundAccent,
          titleTextStyle:
              TextStyle(fontSize: 30, color: ThemeColors.buttonAccent),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle:
              TextStyle(fontSize: 20, color: ThemeColors.foregroundDefault),
          hintStyle:
              TextStyle(fontSize: 20, color: ThemeColors.foregroundDefault),
          errorStyle: TextStyle(fontSize: 16, color: ThemeColors.errorDefault),
          iconColor: ThemeColors.foregroundDefault,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.foregroundAccent)),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.errorDefault)),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.errorDefault)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.buttonDefault,
            foregroundColor: ThemeColors.buttonAccent,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: ThemeColors.buttonDefault,
            foregroundColor: ThemeColors.buttonAccent,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge:
              TextStyle(fontSize: 30, color: ThemeColors.foregroundAccent),
          titleMedium:
              TextStyle(fontSize: 25, color: ThemeColors.foregroundAccent),
          titleSmall: TextStyle(fontSize: 15, color: ThemeColors.buttonAccent),
          displayLarge:
              TextStyle(fontSize: 35, color: ThemeColors.errorDefault),
          displayMedium:
              TextStyle(fontSize: 25, color: ThemeColors.foregroundAccent),
          displaySmall:
              TextStyle(fontSize: 15, color: ThemeColors.foregroundAccent),
          bodySmall:
              TextStyle(fontSize: 13, color: ThemeColors.foregroundAccent),
        ),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: ThemeColors.foregroundAccent),
        cardColor: ThemeColors.buttonDefault,
        errorColor: ThemeColors.errorDefault,
        dialogBackgroundColor: ThemeColors.backgroundDefault,
        colorScheme: const ColorScheme.light(
          primary: ThemeColors.backgroundAccent,
          onPrimary: ThemeColors.foregroundAccent,
          onSurface: ThemeColors.buttonAccent,
        ),
      ),
      routes: {
        '/home': (context) => const Home(),
        '/auth': (context) => const Authentication(),
      },
      initialRoute: isLoggedIn ? '/home' : '/auth',
    ),
  );
}

class NavigationInfo {
  Widget page;
  String label;
  IconData iconData;

  NavigationInfo(this.page, this.label, this.iconData);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentNavIndex = 0;
  static late User user;
  static List<ExerciseData> exerciseData =
      extractDataFromPayload(getDataFromDB(user));

  static List<NavigationInfo> navInfo = [
    NavigationInfo(const Exercises(), "Exercises", Icons.fitness_center),
    NavigationInfo(const History(), "History", Icons.history_sharp)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GainsTrack"),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: logoutAndNavigate,
                child: const Icon(Icons.more_vert),
              )),
        ],
      ),
      body: Center(child: navInfo.elementAt(currentNavIndex).page),
      bottomNavigationBar: BottomNavigationBar(
        items: navInfo
            .map((navInfoItem) => BottomNavigationBarItem(
                icon: Icon(navInfoItem.iconData), label: navInfoItem.label))
            .toList(),
        currentIndex: currentNavIndex,
        onTap: ((newNavIndex) => setState(() {
              currentNavIndex = newNavIndex;
            })),
      ),
    );
  }

  static List<ExerciseData> extractDataFromPayload(
      List<Map<String, Object>> data) {
    return data.map<ExerciseData>(ExerciseData.fromJson).toList();
  }

  static List<Map<String, Object>> getDataFromDB(User user) {
    const data = [
      {
        'id': 1,
        'name': 'Biceps Curls',
        'logData': [
          {
            'id': 101,
            'sets': 1.0,
            'reps': 5.0,
            'weight': 10.0,
            'note': 'note 11',
            'date': '01.01.2023',
          },
          {
            'id': 102,
            'sets': 1.0,
            'reps': 7.0,
            'weight': 15.0,
            'note': 'note 12',
            'date': '02.01.2023',
          },
          {
            'id': 103,
            'sets': 1.0,
            'reps': 5.0,
            'weight': 20.0,
            'note': 'note 13',
            'date': '03.01.2023',
          },
          {
            'id': 104,
            'sets': 2.0,
            'reps': 5.0,
            'weight': 15.0,
            'note': 'note 14',
            'date': '04.01.2023',
          }
        ],
      },
      {
        'id': 2,
        'name': 'Bench Press',
        'logData': [
          {
            'id': 201,
            'sets': 1.0,
            'reps': 5.0,
            'weight': 50.0,
            'note': 'note 21',
            'date': '01.01.2023',
          },
          {
            'id': 202,
            'sets': 1.0,
            'reps': 7.0,
            'weight': 55.0,
            'note': 'note 22',
            'date': '02.01.2023',
          },
          {
            'id': 203,
            'sets': 1.0,
            'reps': 5.0,
            'weight': 70.0,
            'note': 'note 23',
            'date': '03.01.2023',
          },
          {
            'id': 204,
            'sets': 2.0,
            'reps': 5.0,
            'weight': 55.0,
            'note': 'note 24',
            'date': '04.01.2023',
          }
        ],
      },
    ];

    return data;
  }

  Future<void> logoutAndNavigate() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    perfs.setBool('isLoggedIn', false);

    Navigator.popUntil(context, ModalRoute.withName('/home'));
    Navigator.pushReplacementNamed(context, '/auth');
  }
}
