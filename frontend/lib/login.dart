import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              TextField(
                controller: usernameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "User name",
                  hintText: "username or email",
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "password",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(usernameController.text);
                  print(passwordController.text);
                },
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
