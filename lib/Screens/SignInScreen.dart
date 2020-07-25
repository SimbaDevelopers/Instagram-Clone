import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/services/auth.dart';
import 'package:instagram/services/database.dart';
import '../helpfunction.dart';
import 'SignupScreen.dart';
import 'MainScreen.dart';

class Login_Screen extends StatefulWidget {
  static const routName = '/LoginScreen';
  final Function toggle;
  Login_Screen(this.toggle);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

// ignore: camel_case_types
class _Login_ScreenState extends State<Login_Screen> {
  AuthMethod authMethod = new AuthMethod();
  DatabaseMethod databaseMethod = new DatabaseMethod();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTexteditingcontroller =
      new TextEditingController();
  TextEditingController passwordTexteditingcontroller =
      new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotuserinfo;
  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });


      databaseMethod
          .getUserByUserEmail(emailTexteditingcontroller.text.trim())
          .then((val) {
        snapshotuserinfo = val;
        HelperFunction.saveusernameSharedPreferecne(
            snapshotuserinfo.documents[0].data["username"]);
        print("${snapshotuserinfo.documents[0].data["username"]}");
      });


      authMethod
          .signinwithemailandpassword(emailTexteditingcontroller.text,
              passwordTexteditingcontroller.text)
          .then((val) {
        if (val != null) {
          HelperFunction.saveuserloggedinSharedPreferecne(true);
          HelperFunction.saveuseremailSharedPreferecne(
              emailTexteditingcontroller.text);


          FirebaseAuth.instance.currentUser().then((value) => HelperFunction.saveuserIDinSharedPreferecne(value.uid));



          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 135),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Instagram",
                  style: TextStyle(fontSize: 60, fontFamily: 'Billabong'),
                ),
                Form(
                  key: formKey,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 45),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        validator: (val) {
                          return val.isEmpty || val.length < 4 ? "Hi" : null;
                        },
                        controller: emailTexteditingcontroller,
                        decoration: new InputDecoration(
                          labelText: 'Email address',
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey,
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
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
                      child: TextFormField(
                        controller: passwordTexteditingcontroller,
                        decoration: new InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(top: 20, bottom: 10, right: 25, left: 25),
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
                      // Navigator.of(context).pushNamed(MainScreen.routeName);
                      signIn();
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "Login",
                          ),
                  ),
                ),
                Center(
                  // alignment: Alignment.center,
                  // margin: EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Forgotten your login details?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          '  Get help with signing in.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                    )),
                    Text(
                      "  OR  ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                    )),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have a account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                        widget.toggle();
                      },
                      child: Text(
                        '  Sign up.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
