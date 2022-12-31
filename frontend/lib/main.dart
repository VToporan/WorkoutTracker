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
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black38,
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
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: const Text("GainsTrack"),
        centerTitle: true,
        backgroundColor: Colors.orange[400],
        foregroundColor: Colors.red[900],
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
