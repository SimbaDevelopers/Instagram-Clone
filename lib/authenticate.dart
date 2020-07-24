import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/SignInScreen.dart';
import 'package:instagram/Screens/MainScreen.dart';
import 'package:instagram/Screens/SignupScreen.dart';
import 'package:instagram/Screens/SplashScreen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final _auth = FirebaseAuth.instance;
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? Login_Screen(toggleView) : SignUpScreen(toggleView)
        //  StreamBuilder(
        //   stream: _auth.onAuthStateChanged,
        //   builder: (ctx, usersnapshot) {
        //     if (usersnapshot.connectionState == ConnectionState.waiting) {
        //       return SplashScreen();
        //     }

        // if (usersnapshot.hasData) {
        //   return MainScreen();
        // }
        //     if (showSignIn) {
        //       return Login_Screen(toggleView);
        //     } else {
        //       return SignUpScreen(toggleView);
        //     }
        //   },
        // )
        ;
  }
}
