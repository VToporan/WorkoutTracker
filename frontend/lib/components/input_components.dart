import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';

class InputComponent extends StatefulWidget {
  final TextEditingController inputController;
  final String labelText;
  final bool isHidden;
  final GlobalKey<InputComponentState> key;

  const InputComponent({
    required this.key,
    required this.inputController,
    required this.labelText,
    required this.isHidden,
  }) : super(key: key);

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

  bool isEmpty() {
    if (widget.inputController.text.isEmpty) {
      setState(() {
        errorText = "${widget.labelText} can't be empty";
      });
      return true;
    }

    setState(() {
      errorText = "";
    });
    return false;
  }

  void setErrorText(String errorMessage) {
    setState(() {
      errorText = errorMessage;
    });
  }
}

class NumberInputComponent extends InputComponent {
  const NumberInputComponent({
    required super.key,
    required TextEditingController inputController,
    required String labelText,
  }) : super(
          inputController: inputController,
          labelText: labelText,
          isHidden: false,
        );

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
  const LongInputComponent({
    required super.key,
    required TextEditingController inputController,
    required String labelText,
  }) : super(
          inputController: inputController,
          labelText: labelText,
          isHidden: false,
        );

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

class DateInputComponent extends InputComponent {
  const DateInputComponent({
    required super.key,
    required TextEditingController inputController,
    required String labelText,
  }) : super(
          inputController: inputController,
          labelText: labelText,
          isHidden: false,
        );

  @override
  DateInputComponentState createState() => DateInputComponentState();
}

class DateInputComponentState extends InputComponentState {
  @override
  void initState() {
    super.initState();
    widget.inputController.text = formatDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputController,
      style: Theme.of(context).textTheme.displayMedium,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: errorText != "" ? errorText : null,
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
        );

        String formattedDate = formatDate(pickedDate ?? DateTime.now());

        widget.inputController.text = formattedDate;
      },
    );
  }

  String formatDate(DateTime date) {
    return Jiffy(date).format('yyyy-MM-dd');
  }
}
