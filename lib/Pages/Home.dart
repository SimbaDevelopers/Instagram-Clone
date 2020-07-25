import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Chats/chat.dart';
import 'package:instagram/Pages/Activity.dart';
import 'package:instagram/Pages/Add.dart';
import 'package:instagram/Pages/Profile.dart';
import 'package:instagram/Screens/SignInScreen.dart';
import 'package:instagram/Screens/startupscreen.dart';

import 'package:instagram/widgets/PostHomeScreen.dart';
import 'package:instagram/widgets/storybar.dart';

import 'package:instagram/authenticate.dart';
import 'file:///D:/Personal/Personal/Instagram-clone/3/lib/helper/constants.dart';
import 'file:///D:/Personal/Personal/Instagram-clone/3/lib/helper/helpfunction.dart';

import 'package:instagram/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<HomePage> {
  AuthMethod authMethod = new AuthMethod();
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunction.getusernameSharedPreferecne();
    setState(() {});
  }

  File _image;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  getImage(true);
                },
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Instagram',
                style: TextStyle(fontSize: 25.0, fontFamily: 'Billabong'),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chats()),
                  );
                },
                child: Icon(Icons.send),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              StoryBar(),
              Divider(
                color: Colors.white,
              ),
              PostHome(),
            ],
          ),
        ),
      ),
    );
  }
}



// ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: 60,
//                   itemBuilder: (context, index) {
//                     return Text('Some text');
//                   })



//this is for testing.....