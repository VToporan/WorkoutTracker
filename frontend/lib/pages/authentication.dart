import 'package:flutter/material.dart';

import '../components/button_components.dart';
import '../components/input_components.dart';

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
            buttonFunction: () => {},
          ),
          ButtonComponent(
            buttonText: 'Register',
            buttonFunction: () => {},
          ),
        ],
      ),
    );
  }
}
