import 'package:flutter/material.dart';

import 'MainScreen.dart';

class UsernameScreen extends StatelessWidget {
  static const routeName = '/choseUsername';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 30),
              child: Text(
                'choose username',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Text(
              'You can always change it later.',
              style: TextStyle(color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 18),
              child: TextField(
                decoration: new InputDecoration(
                  labelText: 'username',
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
              width: double.infinity,
              margin: EdgeInsets.only(top: 20, bottom: 10, right: 25, left: 25),
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
                  "Next",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
