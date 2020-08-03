import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Settings/Security.dart';
import 'package:instagram/Settings/about.dart';
import 'package:instagram/Settings/ads.dart';
import 'package:instagram/Settings/help.dart';
import 'package:instagram/Settings/privacy.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/provider/PostList.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authenticate.dart';
import 'Notifications.dart';
import 'followandinvite.dart';
class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => FollowAndInvite()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person_add,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Follow and Invite Friends',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => Notifications()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Notification',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => Privacy()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.lock,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Privacy',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => Security()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.security,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Security',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => Ads()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.speaker,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Ads',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.payment,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Payment',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Account',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => Help()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.help_outline,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Help',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => About()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'About',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Logins',
                          style: TextStyle(fontSize: 18),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Set up Multi-Account Login',
                          style: TextStyle(fontSize: 18),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Add Account',
                          style: TextStyle(fontSize: 18,
                          color: Colors.blue),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences preferences =
                await SharedPreferences.getInstance();
                await preferences.clear();

                FirebaseAuth.instance.signOut();
                Constants.imgpro="";

                Provider.of<UserInformation>(context , listen: false).logout();
                Provider.of<PostList>(context , listen: false).logout();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => Authenticate()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                          'Log Out',
                          style: TextStyle(fontSize: 18,
                              color: Colors.blue),
                        )),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
