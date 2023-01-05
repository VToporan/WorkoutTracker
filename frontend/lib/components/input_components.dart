import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputComponent extends StatefulWidget {
  final TextEditingController inputController;
  final String labelText;
  final bool isHidden;

  const InputComponent(
      {super.key,
      required this.inputController,
      required this.labelText,
      required this.isHidden});

  @override
  InputComponentState createState() => InputComponentState();
}

class InputComponentState extends State<InputComponent> {
  bool isVisible = true;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isVisible && widget.isHidden,
      controller: widget.inputController,
      style: Theme.of(context).textTheme.displayMedium,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: errorText != "" ? errorText : null,
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

  bool checkIsEmpty() {
    if (widget.inputController.text.isEmpty) {
      return true;
    }

    return false;
  }

  void setErrorText(String errorMessage) {
    setState(() {
      errorText = errorMessage;
    });
  }
}

class NumberInputComponent extends InputComponent {
  const NumberInputComponent(
      {super.key,
      required TextEditingController inputController,
      required String labelText})
      : super(
            inputController: inputController,
            labelText: labelText,
            isHidden: false);

  @override
  NumberInputComponentState createState() => NumberInputComponentState();
}

class NumberInputComponentState extends InputComponentState {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
      style: Theme.of(context).textTheme.displayMedium,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: errorText != "" ? errorText : null,
      ),
    );
  }
}

class LongInputComponent extends InputComponent {
  const LongInputComponent(
      {super.key,
      required TextEditingController inputController,
      required String labelText})
      : super(
            inputController: inputController,
            labelText: labelText,
            isHidden: false);

  @override
  LongInputComponentState createState() => LongInputComponentState();
}

class LongInputComponentState extends InputComponentState {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputController,
      style: Theme.of(context).textTheme.displayMedium,
      minLines: 3,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: errorText != "" ? errorText : null,
      ),
    );
  }
}
