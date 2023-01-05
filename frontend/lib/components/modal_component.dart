import 'package:GainsTrack/components/input_components.dart';
import 'package:flutter/material.dart';

import 'button_components.dart';
import 'error_component.dart';

class ModalComponent extends StatefulWidget {
  final int id;
  const ModalComponent({super.key, required this.id});

  @override
  State<ModalComponent> createState() => ModalComponentState();
}

class ModalComponentState extends State<ModalComponent> {
  static TextEditingController setController = TextEditingController();
  static TextEditingController repController = TextEditingController();
  static TextEditingController weightController = TextEditingController();
  static TextEditingController notesController = TextEditingController();

  static List<InputComponent> inputs = [
    NumberInputComponent(
      inputController: setController,
      labelText: "Sets",
    ),
    NumberInputComponent(
      inputController: repController,
      labelText: "Reps",
    ),
    NumberInputComponent(
      inputController: weightController,
      labelText: "Weight",
    ),
    LongInputComponent(
      inputController: notesController,
      labelText: "Notes",
    ),
  ];

  var errorMessage = "message";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: inputs,
              ),
            ),
            ErrorComponent(message: errorMessage),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: ButtonComponent(
                    buttonFunction: submitData,
                    buttonText: "Confirm",
                  )),
                  Expanded(
                      child: ButtonComponent(
                    buttonFunction: () => {Navigator.pop(context, true)},
                    buttonText: "Cancel",
                  )),
                ],
              ),
            )
          ]),
    );
  }

  void submitData() {}
}
