import 'package:flutter/material.dart';
import 'package:instagram/Screens/MainScreen.dart';

import 'Add.dart';
import './Home.dart';
import 'Activity.dart';
import './Profile.dart';
import './Search.dart';
import 'Screens/SignupScreen.dart';
import 'Screens/login_or_signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoginOrSignup(),
      routes: {
        SignUpScreen.routeName: (context) => SignUpScreen(),
        LoginOrSignup.routeName: (context) => LoginOrSignup(),
        MainScreen.routeName: (context) => MainScreen(),
      },
    );
  }
}

class LoginScreen {}
