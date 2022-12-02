import 'dart:convert';

import 'package:flutter/material.dart';
import 'components/button_components.dart';
import 'components/input_components.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  static TextEditingController userController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static String errorUser = "";
  static String errorPass = "";

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

    print(payload());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        appBar: AppBar(
          title: const Text("GainsTrack"),
          centerTitle: true,
          backgroundColor: Colors.orange[400],
          foregroundColor: Colors.red[900],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 290, left: 250, right: 250),
                child: Column(
                  children: inputs,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 50, right: 50),
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
        ));
  }
}
