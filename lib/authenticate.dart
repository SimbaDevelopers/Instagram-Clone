import 'package:flutter/material.dart';
import 'package:instagram/Screens/Login_Screen.dart';
import 'package:instagram/Screens/SignupScreen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login_Screen(toggleView);
    } else {
      return SignUpScreen(toggleView);
    }
  }
}
