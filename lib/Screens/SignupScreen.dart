import 'package:flutter/material.dart';
import 'package:instagram/Screens/MainScreen.dart';
import './LoginScreen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/Signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 130, bottom: 40),
                  child: Text(
                    "Instagram",
                    style: TextStyle(fontSize: 60, fontFamily: 'Billabong'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    decoration: new InputDecoration(
                      labelText: 'Email address',
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.grey,
                      focusColor: Colors.grey,
                      contentPadding: EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    decoration: new InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(top: 20, bottom: 10, right: 25, left: 25),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.blue)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(15),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.of(context).pushNamed(MainScreen.routeName);
                    },
                    child: Text(
                      "Sign up",
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Alreaady have a account? ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(LoginScreen.routName);
                        },
                        child: Text(
                          ' Login.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
