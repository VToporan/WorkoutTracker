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
  static TextEditingController controller = TextEditingController();

  static List<InputComponent> inputs = [
    InputComponent(
      inputController: controller,
      labelText: "labelText",
      errorText: "errorText",
      isHidden: false,
    ),
    InputComponent(
      inputController: controller,
      labelText: "labelText",
      errorText: "errorText",
      isHidden: false,
    ),
    InputComponent(
      inputController: controller,
      labelText: "labelText",
      errorText: "errorText",
      isHidden: false,
    ),
    InputComponent(
      inputController: controller,
      labelText: "labelText",
      errorText: "errorText",
      isHidden: false,
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
              child: ButtonComponent(
                buttonFunction: () {},
                buttonText: "Login",
              ),
            )
          ]),
    );
  }
}
