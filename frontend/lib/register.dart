import 'package:flutter/material.dart';

import 'components/button_components.dart';
import 'components/input_components.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  static TextEditingController userController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmController = TextEditingController();

  static String userError = "";
  static String emailError = "";
  static String passError = "";
  static String confirmError = "";

  List<InputComponent> inputs = [
    InputComponent(
      labelText: "Username",
      errorText: userError,
      inputController: userController,
      isHidden: false,
    ),
    InputComponent(
      labelText: "Email",
      errorText: emailError,
      inputController: emailController,
      isHidden: false,
    ),
    InputComponent(
      labelText: "Password",
      errorText: passError,
      inputController: passwordController,
      isHidden: true,
    ),
    InputComponent(
      labelText: "Confirm password",
      errorText: confirmError,
      inputController: confirmController,
      isHidden: true,
    ),
  ];

  attemptRegister() {
    String username = userController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirm = confirmController.text;

    Map<String, dynamic> payload() => {
          'username': username,
          'email': email,
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
                      buttonText: 'Register',
                      buttonFunction: attemptRegister,
                    ),
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
