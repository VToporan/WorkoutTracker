import 'package:flutter/material.dart';

import '../components/button_components.dart';
import '../components/input_components.dart';

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

  bool isError = false;
  String errorMessage = "";

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

    if (username.isEmpty) {
      isError = true;
      userError = "Username can't be empty";
    }

    if (email.isEmpty) {
      isError = true;
      emailError = "Email can't be empty";
    }

    if (password.isEmpty) {
      isError = true;
      passError = "Password can't be empty";
    }

    if (confirm.isEmpty) {
      isError = true;
      confirmError = "Confirm password can't be empty";
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
    });
    userError = "";
    emailError = "";
    passError = "";
    confirm = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 250, right: 250),
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
                  buttonText: 'Register',
                  buttonFunction: attemptRegister,
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
