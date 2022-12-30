import 'package:flutter/material.dart';
import 'components/button_components.dart';
import 'components/card_component.dart';

class Exercises extends StatefulWidget {
  const Exercises({super.key});

  @override
  State<Exercises> createState() => ExercisesState();
}

class ExercisesState extends State<Exercises> {
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
            CardComponent(title: "Title 1", subTitle: "Subtitle 1"),
            CardComponent(title: "Title 2", subTitle: "Subtitle 2"),
          ],
        )));
  }
}
