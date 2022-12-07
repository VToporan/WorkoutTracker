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
      obscureText: isVisible && widget.isHidden,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      controller: widget.inputController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.amberAccent),
        errorText: widget.errorText != "" ? widget.errorText : null,
        errorStyle:
            widget.errorText != "" ? const TextStyle(fontSize: 15) : null,
        suffixIcon: widget.isHidden
            ? IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.amberAccent,
                ),
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                })
            : null,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }
}
