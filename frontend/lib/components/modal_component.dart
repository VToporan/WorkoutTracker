import 'package:GainsTrack/components/input_components.dart';
import 'package:flutter/material.dart';

import 'button_components.dart';
import 'error_component.dart';
import 'input_components.dart';

class ModalComponent extends StatefulWidget {
  final String title;
  final List<InputComponent> inputs;
  final Function() onSubmit;
  final GlobalKey key;

  const ModalComponent({
    required this.key,
    required this.title,
    required this.inputs,
    required this.onSubmit,
  });

  @override
  State<ModalComponent> createState() => ModalComponentState();
}

class ModalComponentState extends State<ModalComponent> {
  // late List<InputComponent> inputs;

  @override
  void initState() {
    super.initState();
    // inputs = widget.inputs;
  }

  late String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: widget.inputs,
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
                    buttonFunction: widget.onSubmit,
                    buttonText: "Confirm",
                  )),
                ],
              ),
            )
          ]),
    );
  }

  setErrorMessage(message) {
    setState(() {
      errorMessage = message;
    });
  }
}
