import 'package:flutter/material.dart';

import 'pages/exercises.dart';
import 'pages/history.dart';
import 'pages/authentication.dart';

class ThemeColors {
  ThemeColors._();

  static const Color buttonDefault = Color(0xFF403A40);
  static const Color buttonAccent = Color(0xFF908090);
  static const Color foregroundDefault = Color(0xFF504550);
  static const Color foregroundAccent = Color(0xFFAA99AA);
  static const Color backgroundDefault = Color(0xFF100010);
  static const Color errorDefault = Color(0xFFD03070);
}

void main() {
  bool isAuthenticated = true;

  runApp(
    MaterialApp(
      title: "Workout Tracker",
      theme: ThemeData(
        primaryColor: ThemeColors.foregroundAccent,
        scaffoldBackgroundColor: ThemeColors.backgroundDefault,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ThemeColors.buttonDefault,
          selectedItemColor: ThemeColors.buttonAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ThemeColors.buttonDefault,
          titleTextStyle:
              TextStyle(fontSize: 30, color: ThemeColors.buttonAccent),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle:
              TextStyle(fontSize: 30, color: ThemeColors.foregroundDefault),
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
        textTheme: const TextTheme(
          titleMedium:
              TextStyle(fontSize: 30, color: ThemeColors.foregroundAccent),
          titleSmall:
              TextStyle(fontSize: 20, color: ThemeColors.foregroundAccent),
          displayMedium:
              TextStyle(fontSize: 25, color: ThemeColors.foregroundAccent),
          displayLarge:
              TextStyle(fontSize: 35, color: ThemeColors.errorDefault),
        ),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: ThemeColors.foregroundAccent),
        cardColor: ThemeColors.foregroundDefault,
        errorColor: ThemeColors.errorDefault,
      ),
      routes: {
        '/home': (context) => const Home(),
        '/auth': (context) => const Authentication(),
      },
      initialRoute: isAuthenticated ? '/home' : '/auth',
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
  static List<NavigationInfo> navInfo = [
    NavigationInfo(const Exercises(), "Exercises", Icons.fitness_center),
    NavigationInfo(const History(), "History", Icons.history_sharp)
  ];
  int currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GainsTrack"),
        centerTitle: true,
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
}
