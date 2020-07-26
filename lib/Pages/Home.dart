import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Chats/chat.dart';
import 'package:instagram/Pages/Activity.dart';
import 'package:instagram/Pages/Add.dart';
import 'package:instagram/Pages/Profile.dart';
import 'package:instagram/Pages/Search.dart';
import 'package:instagram/Screens/SignInScreen.dart';
import 'package:instagram/Screens/startupscreen.dart';
import 'package:instagram/helper/constants.dart';

import 'package:instagram/widgets/PostHomeScreen.dart';
import 'package:instagram/widgets/storybar.dart';

import 'package:instagram/authenticate.dart';

//import 'package:instagram/constants.dart';
import 'bottom_nav.dart';
import 'file:///D:/Ongoing%20Projects/Instagram-Clone-2/lib/helper/helpfunction.dart';

//import 'helper/constants.dart';
//import 'helper/helpfunction.dart';




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
              Text('asdsa'),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation('HomePage' , context),
//        bottomNavigationBar: BottomNavigation('HomePage' , context),
//        bottomNavigationBar: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//
//              GestureDetector(
//
//                  child: Icon(Icons.home , size: 35, color: Colors.white,),
//              ),
//              GestureDetector(
//                onTap: (){
//                    Navigator.of(context).pushNamed(SearchPage.routeName);
//                },
//                child: Icon(Icons.search, size: 35, color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(AddPage.routeName);
//                },
//                child: Icon(Icons.add, size: 35,color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(ActivityPage.routeName);
//
//                },
//                child: Icon(Icons.favorite_border, size: 35,color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(ProfilePage.routeName);
//                },
//                child: Icon(Icons.supervised_user_circle, size: 35,color: Colors.grey,),
//              ),
//
//            ],
//          ),
//        ),
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