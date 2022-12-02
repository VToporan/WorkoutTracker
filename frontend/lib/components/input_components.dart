import 'package:flutter/material.dart';

class InputComponent extends StatefulWidget {
  final TextEditingController inputController;
  final String labelText;
  final String errorText;
  final bool isHidden;

  const InputComponent(
      {super.key,
      required this.inputController,
      required this.labelText,
      required this.errorText,
      required this.isHidden});

  @override
  State<InputComponent> createState() => InputComponentVisible();
}

class InputComponentVisible extends State<InputComponent> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      obscureText: !isVisible,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      controller: widget.inputController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.amberAccent),
        suffixIcon: widget.isHidden
            ? IconButton(
                icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                })
            : null,
      ),
    );
  }
}
