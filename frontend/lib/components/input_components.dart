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
      obscureText: isVisible && widget.isHidden,
      controller: widget.inputController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText != "" ? widget.errorText : null,
        suffixIcon: widget.isHidden
            ? IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                ),
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
