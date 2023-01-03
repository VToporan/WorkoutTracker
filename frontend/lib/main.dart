import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'components/card_component.dart';
import 'pages/exercises.dart';
import 'pages/history.dart';
import 'pages/login.dart';
import 'pages/register.dart';

class ThemeColors {
  ThemeColors._();

  static const Color buttonDefault = Color(0xFF403A40);
  static const Color buttonAccent = Color(0xFF908090);
  static const Color foregroundDefault = Color(0xFF504050);
  static const Color foregroundAccent = Color(0xFFAA99AA);
  static const Color backgroundDefault = Color(0xFF100010);
}

void main() {
  runApp(MaterialApp(
      title: "Workout Tracker",
      theme: ThemeData(
        primaryColor: ThemeColors.foregroundDefault,
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
              TextStyle(fontSize: 35, color: ThemeColors.foregroundDefault),
          hintStyle:
              TextStyle(fontSize: 20, color: ThemeColors.foregroundDefault),
          errorStyle:
              TextStyle(fontSize: 15, color: ThemeColors.foregroundAccent),
          iconColor: ThemeColors.foregroundDefault,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.foregroundAccent)),
        ),
        textTheme: const TextTheme(
          titleMedium:
              TextStyle(fontSize: 30, color: ThemeColors.foregroundAccent),
          titleSmall:
              TextStyle(fontSize: 20, color: ThemeColors.foregroundAccent),
          displayMedium: TextStyle(fontSize: 25, color: Colors.white),
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
        cardColor: ThemeColors.foregroundDefault,
      ),
      home: const Home()));
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
    NavigationInfo(const Exercises(), "Home", Icons.home),
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
