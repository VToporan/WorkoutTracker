import 'dart:convert';

import 'package:flutter/material.dart';
import '../components/button_components.dart';
import '../components/input_components.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  static TextEditingController userController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static String errorUser = "";
  static String errorPass = "";
  bool isError = false;
  String errorMessage = "";

  List<InputComponent> inputs = [
    InputComponent(
      inputController: userController,
      labelText: "Username",
      errorText: errorUser,
      isHidden: false,
    ),
    InputComponent(
      inputController: passwordController,
      labelText: "Password",
      errorText: errorPass,
      isHidden: true,
    ),
  ];

  attemptLogin() {
    String username = userController.text;
    String password = passwordController.text;

    Map<String, dynamic> payload() => {
          'username': username,
          'password': password,
        };

    if (username.isEmpty) {
      isError = true;
      errorUser = "Username can't be empty";
    }

    if (password.isEmpty) {
      isError = true;
      errorPass = "Password can't be empty";
    }

    if (isError) {
      isError = false;
      errorMessage = "Something went wrong";
    } else {
      errorMessage = "";
    }

    setState(() {
      inputs = [
        InputComponent(
          inputController: userController,
          labelText: "Username",
          errorText: errorUser,
          isHidden: false,
        ),
        InputComponent(
          inputController: passwordController,
          labelText: "Password",
          errorText: errorPass,
          isHidden: true,
        ),
      ];
    });
    errorUser = "";
    errorPass = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: inputs,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
            ),
            child: errorMessage != ""
                ? Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(children: [
              SizedBox(
                height: 70,
                child: ButtonComponent(
                  buttonText: 'Login',
                  buttonFunction: attemptLogin,
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
