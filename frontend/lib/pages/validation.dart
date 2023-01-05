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
  static TextEditingController userController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmController = TextEditingController();

  static bool isError = false;
  static String errorMessage = "";

  late List<InputComponent> inputs;

  @override
  void initState() {
    super.initState();
    resetError();
    clearControllers();

    if (widget.isLoginPage) {
      setLoginInputs();
    } else {
      setRegisterInputs();
    }
  }

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
          )
        ],
      ),
    );
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
    String username = userController.text;
    String email = emailController.text;
    String password = passwordController.text;
    resetError();

    validateUsername(username);
    validateEmail(email);
    validatePassword(password);
    validateConfirmPassword(password);

    if (isError) {
      errorMessage = "Invalid inputs";
    }

    Map<String, dynamic> payload = {
      'username': username,
      'email': email,
      'password': password,
    };

    setState(() {
      setRegisterInputs();
    });
  }

  void attemptLogin() {
    String username = userController.text;
    String password = passwordController.text;
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

    setState(() {
      setLoginInputs();
    });
  }

  void setRegisterInputs() {
    inputs = [
      InputComponent(
        labelText: "Username",
        inputController: userController,
        isHidden: false,
      ),
      InputComponent(
        labelText: "Email",
        inputController: emailController,
        isHidden: false,
      ),
      InputComponent(
        labelText: "Password",
        inputController: passwordController,
        isHidden: true,
      ),
      InputComponent(
        labelText: "Confirm password",
        inputController: confirmController,
        isHidden: true,
      ),
    ];
  }

  void setLoginInputs() {
    inputs = [
      InputComponent(
        inputController: userController,
        labelText: "Username",
        isHidden: false,
      ),
      InputComponent(
        inputController: passwordController,
        labelText: "Password",
        isHidden: true,
      ),
    ];
  }

  void validateUsername(String username) {
    if (username.isEmpty) {
      isError = true;
      return;
    }
  }

  void validateEmail(String email) {
    if (email.isEmpty) {
      isError = true;
      return;
    }
  }

  void validatePassword(String password) {
    if (password.isEmpty) {
      isError = true;
      return;
    }
  }

  void validateConfirmPassword(String password) {
    String confirm = confirmController.text;
    if (confirm.isEmpty) {
      isError = true;
      return;
    }
  }

  void resetError() {
    errorMessage = "";
    isError = false;
  }

  void clearControllers() {
    userController.clear();
    emailController.clear();
    passwordController.clear();
    confirmController.clear();
  }
}
