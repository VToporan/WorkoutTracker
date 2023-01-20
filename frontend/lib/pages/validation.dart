import 'dart:convert';

import 'package:GainsTrack/main.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/button_components.dart';
import '../components/error_component.dart';
import '../components/input_components.dart';
import '../storage/user_data_storage.dart';

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

  void attemptRegister() async {
    String username = userInput.inputController.text;
    String email = emailInput.inputController.text;
    String password = passwordInput.inputController.text;
    resetError();

    verifyInputsNotEmpty();
    if (isError) return;
    validateUsername(username);
    validateEmail(email);
    validatePassword(password);
    validateConfirmPassword(password);

    Digest hashedPassword = hashPassword(username, password);

    try {
      final response = await post(
        Uri.parse('http://localhost:8080/users/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': hashedPassword.toString(),
        }),
      );

      if (response.statusCode == StatusCode.CONFLICT) {
        setError("Username or email already exist");
        return;
      }

      HomeState.user = User.fromJson(json.decode(response.body));
    } catch (e) {
      setError("No connection");
    }

    if (isError) return;

    await loginAndNavigate();
  }

  Future<void> attemptLogin() async {
    String username = userInput.inputController.text;
    String password = passwordInput.inputController.text;
    resetError();

    verifyInputsNotEmpty();
    validateUsername(username);
    validatePassword(password);

    if (isError) return;

    Digest hashedPassword = hashPassword(username, password);

    try {
      final response = await post(
        Uri.parse('http://localhost:8080/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': hashedPassword.toString(),
        }),
      );

      if (response.statusCode == StatusCode.CONFLICT) {
        setError("Username does not exist");
        return;
      }

      if (response.statusCode == StatusCode.NOT_ACCEPTABLE) {
        setError("Incorrect password");
        return;
      }

      HomeState.user = User.fromJson(json.decode(response.body));
    } catch (e) {
      setError("No connection");
    }

    if (isError) return;
    await loginAndNavigate();
  }

  Future<void> loginAndNavigate() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    perfs.setBool('isLoggedIn', true);

    Navigator.popUntil(context, ModalRoute.withName('/auth'));
    Navigator.pushReplacementNamed(context, '/home');
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

  void setError(String message) {
    setState(() {
      isError = true;
      errorMessage = message;
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
        setError("Invalid inputs");
      }
    }
  }

  Digest hashPassword(String username, String password) {
    var salt = utf8.encode(username);
    var pass = utf8.encode(password);

    var hash256 = Hmac(sha256, salt);
    return hash256.convert(pass);
  }
}
