import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstPasswordController = TextEditingController();
  final TextEditingController secondPasswordController =
      TextEditingController();

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
                "Register Screen",
                style: TextStyle(color: Colors.white),
              ),
              TextField(
                controller: usernameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "email",
                ),
              ),
              TextField(
                controller: emailController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "User name",
                  hintText: "username",
                ),
              ),
              TextField(
                controller: firstPasswordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "password",
                ),
              ),
              TextField(
                controller: secondPasswordController,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "confirm password",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(usernameController.text);
                  print(emailController.text);
                  print(firstPasswordController.text);
                  print(secondPasswordController.text);
                },
                child: const Text("Sign up"),
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
