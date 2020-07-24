import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram/widgets/PostAtProfile.dart';
import 'package:instagram/widgets/SettingsDrawer.dart';
import 'package:instagram/widgets/StoryHighlite.dart';

import '../helpfunction.dart';
import '../widgets/InfoAtProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authenticate.dart';

void main() => runApp(ProfilePage());

class ProfilePage extends StatefulWidget {
  static const routeName = '/ProfilePage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';

  void getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    // await HelperFunction.getusernameSharedPreferecne().then((value) {
    //   setState(() {
    //     print(value);
    //     userName = value;
    //   });
    // });

    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .get()
        .then((snapShot) {
      setState(() {
        userName = snapShot.data['username'];
      });
    });
  }

  @override
  void initState() {
    print('zdf');
    getUserInfo();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          title: userName == null ? Text('usename') : new Text(userName),
        ),
        endDrawer: SettingsDrawer(),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              InfoAtProfile(),
              StoryHighights(),
              PostAtProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
