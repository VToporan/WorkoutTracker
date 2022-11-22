import 'package:flutter/material.dart';
import 'components.dart';

class Login extends StatelessWidget {
  Login({super.key});

  List<InputComponent> inputs = [
    InputComponent(labelText: "username", labelHint: "username"),
    InputComponent(labelText: "password", labelHint: "password"),
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
              const Text(
                "Login Screen",
                style: TextStyle(color: Colors.white),
              ),
              inputs[0],
              inputs[1],
              ElevatedButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Home"),
              ),
            ],
          ),
        ));
  }
}
