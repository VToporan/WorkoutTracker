import 'package:GainsTrack/components/input_components.dart';
import 'package:flutter/material.dart';

import 'button_components.dart';
import 'error_component.dart';
import 'input_components.dart';

class ModalComponent extends StatefulWidget {
  final int id;
  const ModalComponent({super.key, required this.id});

  @override
  State<ModalComponent> createState() => ModalComponentState();
}

class ModalComponentState extends State<ModalComponent> {
  NumberInputComponent setsInput = NumberInputComponent(
    key: GlobalKey<InputComponentState>(),
    inputController: TextEditingController(),
    labelText: "Sets",
  );

  NumberInputComponent repsInput = NumberInputComponent(
    key: GlobalKey<InputComponentState>(),
    inputController: TextEditingController(),
    labelText: "Reps",
  );
  NumberInputComponent weightInput = NumberInputComponent(
    key: GlobalKey<InputComponentState>(),
    inputController: TextEditingController(),
    labelText: "Weight",
  );
  LongInputComponent notesInput = LongInputComponent(
    key: GlobalKey<InputComponentState>(),
    inputController: TextEditingController(),
    labelText: "Notes",
  );

  DateInputComponent dateInput = DateInputComponent(
      key: GlobalKey<InputComponentState>(),
      inputController: TextEditingController(),
      labelText: "Date");

  late List<InputComponent> inputs;
  bool isError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    inputs = [
      setsInput,
      repsInput,
      weightInput,
      dateInput,
      notesInput,
    ];
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: ButtonComponent(
                    buttonFunction: () => {Navigator.pop(context, true)},
                    buttonText: "Cancel",
                  )),
                  Expanded(
                      child: ButtonComponent(
                    buttonFunction: submitData,
                    buttonText: "Confirm",
                  )),
                ],
              ),
            )
          ]),
    );
  }

  void submitData() {
    resetError();
    verifyInputsNotEmpty();
    if (isError) {
      setState(() {
        errorMessage = "Invalid inputs";
      });
    }
  }

  void verifyInputsNotEmpty() {
    for (InputComponent input in inputs) {
      if (input != notesInput) {
        if (input.key.currentState!.isEmpty()) {
          isError = true;
        }
      }
    }
  }

  void resetError() {
    setState(() {
      isError = false;
      errorMessage = "";
    });
  }

  void clearControllers() {
    for (InputComponent input in inputs) {
      input.inputController.clear();
    }
  }
}
