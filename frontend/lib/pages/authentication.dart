import 'package:flutter/material.dart';

import '../components/button_components.dart';
import '../pages/login.dart';
import '../pages/register.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => AuthenticationState();
}

class AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ButtonComponent(
            buttonText: 'Login',
            buttonFunction: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => const Login())));
            },
          ),
          ButtonComponent(
            buttonText: 'Register',
            buttonFunction: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => const Register())));
            },
          ),
        ],
      ),
    );
  }
}
