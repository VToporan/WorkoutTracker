import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final Function() buttonFunction;
  final String buttonText;

  const ButtonComponent(
      {super.key, required this.buttonFunction, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.4,
      child: ElevatedButton(
        onPressed: buttonFunction,
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.titleMedium,
              textScaleFactor: 0.9,
            )),
      ),
    );
  }
}
