import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram/widgets/PostAtProfile.dart';
import 'package:instagram/widgets/SettingsDrawer.dart';
import 'package:instagram/widgets/StoryHighlite.dart';

import '../helper/helpfunction.dart';
import '../widgets/InfoAtProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authenticate.dart';
import 'Activity.dart';
import 'Add.dart';
import 'Home.dart';
import 'Search.dart';
import 'bottom_nav.dart';

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
     await HelperFunction.getusernameSharedPreferecne().then((value) {
       setState(() {
         print(value);
         userName = value;
       });
     });

//    await Firestore.instance
//        .collection("users")
//        .document(user.uid)
//        .get()
//        .then((snapShot) {
//      setState(() {
//        userName = snapShot.data['username'];
//      });
//    });
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
    return
//      new
//      WillPopScope(
//      onWillPop: _onWillPop,
//      child:
//      new
      Scaffold(
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
        bottomNavigationBar: BottomNavigation('ProfilePage' , context),
//        bottomNavigationBar: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(HomePage.routeName);
//                },
//                child: Icon(Icons.home , size: 35, color: Colors.white,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(SearchPage.routeName);
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
//                onTap: (){},
//                child: Icon(Icons.supervised_user_circle, size: 35,color: Colors.grey,),
//              ),
//
//            ],
//          ),
//        ),
//      ),
    );
  }
}
