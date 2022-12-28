import 'package:flutter/material.dart';

import 'components/card_component.dart';
import 'history.dart';
import 'login.dart';
import 'register.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({super.key});

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
        body: Center(
          child: Column(
            children: [
              const CardComponent(
                title: "Card 1",
                subTitle: "Sub 1",
                index: 1,
              ),
              const CardComponent(
                title: "Card 2",
                subTitle: "Sub 2",
                index: 2,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const History()));
                },
                child: const Text("L'historie"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text("L'ogin"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: const Text("R'egister"),
              ),
            ],
          ),
        ));
  }
}
