import 'package:flutter/material.dart';

class ErrorComponent extends StatefulWidget {
  final String message;
  const ErrorComponent({super.key, required this.message});

  @override
  State<ErrorComponent> createState() => ErrorComponentState();
}

class ErrorComponentState extends State<ErrorComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: widget.message != ""
          ? Text(
              widget.message,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            )
          : null,
    );
  }
}
