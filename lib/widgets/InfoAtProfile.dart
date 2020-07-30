import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/widgets/EditProfile.dart';
import 'package:instagram/widgets/followingBottomSheet.dart';

import '../helper/helpfunction.dart';

class InfoAtProfile extends StatefulWidget {
  @override
  _InfoAtProfileState createState() => _InfoAtProfileState();
}

class _InfoAtProfileState extends State<InfoAtProfile> {
  FirebaseUser currentUser;
  String curreentUid;
  String userName,name,bio;
  String profileImage;
  void getUserInfo() async {


    HelperFunction.getusernameSharedPreferecne().then((value) {
        userName = value;
        HelperFunction.getuserIdSharedPreferecne().then((uid) {
          curreentUid = uid;
          HelperFunction.getnameSharedPreferecne().then((value) {
            name=value;
            HelperFunction.getuserbioSharedPreferecne().then((value) {
              bio=value;
              HelperFunction.getProfileImageUrlSharedPreference().then((
                  profImage) {
                setState(() {
                  profileImage = profImage;
                });
              });
            });
      });
    });
    });

  }

  void followingButtonPressed(context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return FollowingBottmSheet();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 45.0,
                backgroundImage: profileImage == null ?  AssetImage('assets/images/profile.jpeg') :   NetworkImage(profileImage),
                backgroundColor: Colors.transparent,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text('12'), Text('Posts')],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text('324'), Text('Followers')],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text('456'), Text('Following')],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:name==null ? Text("") : Text(name),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: bio==null ? Text("") : Text(bio),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.deepPurple[400])),
                  color: Colors.deepPurple[400],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    followingButtonPressed(context);
                  },
                  child: Text(
                    ' Following ▼ ',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.deepPurple[400])),
                  color: Colors.deepPurple[400],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(7),
                  splashColor: Colors.blueAccent,
                  onPressed: () {},
                  child: Text(
                    ' Message ',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.deepPurple[400])),
            color: Colors.deepPurple[400],
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(7),
            splashColor: Colors.blueAccent,
            onPressed: () {
              Navigator.of(context).pushNamed(EditProfile.routeName);
            },
            child: Text(
              ' Edit Profile ',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
