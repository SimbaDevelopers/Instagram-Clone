import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/SplashScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 150),
              height: 150,
              width: 150,
              child: Image.asset('assets/images/logo.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Instagram",
                style: TextStyle(fontSize: 60, fontFamily: 'Billabong'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
