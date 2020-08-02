import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Pages/Home.dart';
import 'package:instagram/Screens/MainScreen.dart';
import 'package:instagram/Screens/usernameScreen.dart';
import 'package:instagram/helper/helpfunction.dart';
import 'package:instagram/services/auth.dart';
import 'package:instagram/services/database.dart';

import 'SignInScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/Signup';

  final Function toggle;
  SignUpScreen(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  bool isLoading = false;

  AuthMethod authMethod = new AuthMethod();
  final formkey = GlobalKey<FormState>();
  DatabaseMethod databaseMethod = new DatabaseMethod();

  TextEditingController usernameTexteditingcontroller =
      new TextEditingController();
  TextEditingController emailTexteditingcontroller =
      new TextEditingController();
  TextEditingController passwordTexteditingcontroller =
      new TextEditingController();

  signMeUp()  {
    if (formkey.currentState.validate()) {


      HelperFunction.saveusernameSharedPreferecne(
          usernameTexteditingcontroller.text);
      HelperFunction.saveuseremailSharedPreferecne(
          emailTexteditingcontroller.text);

      setState(() {
        isLoading = true;
      });
      authMethod
          .signupwithemailandpassword(emailTexteditingcontroller.text.trim(),
              passwordTexteditingcontroller.text.trim())
          .then((val)  {
    //    print("$val.uid");

        String _userId;
         FirebaseAuth.instance.currentUser().then((user) {
          print('uid' + user.uid);
          _userId = user.uid;

          Map<String, Object> userInfoMap = {
            "username"         : usernameTexteditingcontroller.text.trim(),
            "email"            : emailTexteditingcontroller.text.trim(),
            'userId'           : _userId,
            'bio'              : 'bio',
            'name'             : 'Name',
            'phoneNumber'      : '',
            'profileImageURL'  : '',
            'website'          : '',
            'followingsMap'    : { _userId : true},
            'followersMap'     : {},
            'followersCount'   : 0,
            'followingsCount'  : 0,
            'postCount'        : 0,
            'closeFriendsMap'  : {},
            'whoAddedUinCFsMap': {},
            'closeFriendsCount': 0,
          };

          HelperFunction.saveuserIDinSharedPreferecne(_userId);

          databaseMethod.uploadUserInfo(userInfoMap, _userId);
          HelperFunction.saveuserloggedinSharedPreferecne(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 130, bottom: 40),
                        child: Text(
                          "Instagram",
                          style:
                              TextStyle(fontSize: 60, fontFamily: 'Billabong'),
                        ),
                      ),
                      Form(
                        key: formkey,
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.only(left: 25, right: 25),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 4
                                    ? "Hi"
                                    : null;
                              },
                              controller: usernameTexteditingcontroller,
                              decoration: new InputDecoration(
                                labelText: 'username',
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.grey,
                                focusColor: Colors.grey,
                                contentPadding: EdgeInsets.all(15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 25, right: 25, top: 20),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: emailTexteditingcontroller,
                              decoration: new InputDecoration(
                                labelText: 'Email address',
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.grey,
                                focusColor: Colors.grey,
                                contentPadding: EdgeInsets.all(15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 25, right: 25, top: 20),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: passwordTexteditingcontroller,
                              decoration: new InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.all(15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: 20, bottom: 10, right: 25, left: 25),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.deepPurple[400])),
                          color: Colors.deepPurple[400],
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(15),
                          splashColor: Colors.deepPurpleAccent,
                          onPressed: () {
                            signMeUp();
                            // Navigator.of(context).pushNamed(UsernameScreen.routeName);
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
                                // Navigator.of(context).pushNamed(Login_Screen.routName);
                                widget.toggle();
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
