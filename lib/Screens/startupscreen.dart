import 'package:flutter/material.dart';
import 'SignupScreen.dart';
import 'Login_Screen.dart';

class LoginOrSignup extends StatelessWidget {
  static const routeName = '/LoginOrSignup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 170),
            child: Column(
              children: <Widget>[
                Text(
                  "Instagram",
                  style: TextStyle(fontSize: 60, fontFamily: 'Billabong'),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(top: 50, bottom: 20, right: 20, left: 20),
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(15),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.blue)),
                    child: Text(
                      "Create A New Account",
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Login_Screen.routName);
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
