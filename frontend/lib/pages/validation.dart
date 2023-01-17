import 'package:flutter/material.dart';

import '../components/button_components.dart';
import '../components/error_component.dart';
import '../components/input_components.dart';

class Validate extends StatefulWidget {
  final bool isLoginPage;
  const Validate({super.key, required this.isLoginPage});

  @override
  State<Validate> createState() => ValidateState();
}

class ValidateState extends State<Validate> {
  InputComponent userInput = InputComponent(
    key: GlobalKey<InputComponentState>(),
    labelText: "Username",
    inputController: TextEditingController(),
    isHidden: false,
  );
  InputComponent emailInput = InputComponent(
    key: GlobalKey<InputComponentState>(),
    labelText: "Email",
    inputController: TextEditingController(),
    isHidden: false,
  );
  InputComponent passwordInput = InputComponent(
    key: GlobalKey<InputComponentState>(),
    labelText: "Password",
    inputController: TextEditingController(),
    isHidden: true,
  );
  InputComponent confirmInput = InputComponent(
    key: GlobalKey<InputComponentState>(),
    labelText: "Confirm password",
    inputController: TextEditingController(),
    isHidden: true,
  );

  static bool isError = false;
  static String errorMessage = "";

  late List<InputComponent> inputs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GainsTrack"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            child: submitButton(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.isLoginPage) {
      setLoginInputs();
    } else {
      setRegisterInputs();
    }

    resetError();
    clearControllers();
  }

  Widget submitButton() {
    if (widget.isLoginPage) {
      return ButtonComponent(
        buttonFunction: attemptLogin,
        buttonText: "Login",
      );
    } else {
      return ButtonComponent(
        buttonFunction: attemptRegister,
        buttonText: "Register",
      );
    }
  }

  void attemptRegister() {
    String username = userInput.inputController.text;
    String email = emailInput.inputController.text;
    String password = passwordInput.inputController.text;
    resetError();

    verifyInputsNotEmpty();
    if (isError) {
      setState(() {
        errorMessage = "Invalid inputs";
      });
      return;
    }
    validateUsername(username);
    validateEmail(email);
    validatePassword(password);
    validateConfirmPassword(password);

    Map<String, dynamic> payload = {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  void attemptLogin() {
    String username = userInput.inputController.text;
    String password = passwordInput.inputController.text;
    resetError();

    validateUsername(username);
    validatePassword(password);

    if (isError) {
      errorMessage = "Invalid inputs";
    }

    Map<String, dynamic> payload = {
      'username': username,
      'password': password,
    };
  }

  void setRegisterInputs() {
    inputs = [
      userInput,
      emailInput,
      passwordInput,
      confirmInput,
    ];
  }

  void setLoginInputs() {
    inputs = [
      userInput,
      passwordInput,
    ];
  }

  void validateUsername(String username) {}

  void validateEmail(String email) {}

  void validatePassword(String password) {}

  void validateConfirmPassword(String password) {}

  void resetError() {
    setState(() {
      isError = false;
      errorMessage = "";
    });
  }

  void clearControllers() {
    for (InputComponent input in inputs) {
      input.inputController.clear();
    }
  }

  void verifyInputsNotEmpty() {
    for (InputComponent input in inputs) {
      if (input.key.currentState!.isEmpty()) {
        isError = true;
      }
    }
  }
}
