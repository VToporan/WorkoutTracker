import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final Function() buttonFunction;
  final String buttonText;

  const ButtonComponent(
      {super.key, required this.buttonFunction, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: ElevatedButton(
        onPressed: buttonFunction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amberAccent,
          foregroundColor: Colors.red,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
