import 'package:flutter/material.dart';
import 'components/button_components.dart';
import 'components/input_components.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  static TextEditingController loginController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  List<InputComponent> inputs = [
    InputComponent(
      inputController: loginController,
      labelText: "Username",
      errorText: "Username",
      isHidden: false,
    ),
    InputComponent(
      inputController: passwordController,
      labelText: "Password",
      errorText: "Password",
      isHidden: true,
    ),
  ];

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
                padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                child: Column(
                  children: inputs,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                child: Column(children: [
                  ButtonComponent(
                      buttonFunction: () {
                        print('yay');
                        print(loginController.text);
                        print(passwordController.text);
                      },
                      buttonText: 'test'),
                  ButtonComponent(
                      buttonFunction: () {
                        Navigator.pop(context);
                      },
                      buttonText: "home"),
                ]),
              ),
            ],
          ),
        ));
  }
}
