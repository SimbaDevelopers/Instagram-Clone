import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authenticate.dart';

void main() => runApp(ProfilePage());

class ProfilePage extends StatelessWidget {
  static const routeName = '/ProfilePage';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Container(
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(15),
            splashColor: Colors.blueAccent,
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Text(
              "Log Out",
            ),
          ),
        ),
      ),
    );
  }
}
