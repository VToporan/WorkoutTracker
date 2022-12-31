import 'dart:ui';

import 'package:flutter/material.dart';

import 'components/card_component.dart';
import 'pages/exercises.dart';
import 'pages/history.dart';
import 'pages/login.dart';
import 'pages/register.dart';

void main() {
  runApp(MaterialApp(
      title: "Workout Tracker",
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
        scaffoldBackgroundColor: Colors.black38,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.amberAccent,
          selectedItemColor: Colors.red,
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.red,
          backgroundColor: Colors.amberAccent,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(fontSize: 35, color: Colors.amberAccent),
          hintStyle: TextStyle(fontSize: 20, color: Colors.amberAccent),
          errorStyle: TextStyle(fontSize: 15, color: Colors.red),
          iconColor: Colors.amberAccent,
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
        textTheme: const TextTheme(
          subtitle1: TextStyle(fontSize: 30, color: Colors.white),
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
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
    NavigationInfo(const Login(), "Home", Icons.home),
    NavigationInfo(const History(), "History", Icons.history_sharp)
  ];
  int currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
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
