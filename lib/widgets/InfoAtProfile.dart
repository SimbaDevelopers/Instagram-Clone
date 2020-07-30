import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/widgets/EditProfile.dart';
import 'package:instagram/widgets/followingBottomSheet.dart';

import '../helper/helpfunction.dart';

class InfoAtProfile extends StatefulWidget {

  UserModel user;

  InfoAtProfile({this.user});
  @override
  _InfoAtProfileState createState() => _InfoAtProfileState();
}

class _InfoAtProfileState extends State<InfoAtProfile> {


  bool isMe  ;

  void getUserInfo() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
      user.uid == widget.user.userId ? isMe = true : isMe = false;
       // print(' prof image in infoAt :' + widget.userMap['profileImage']);
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
    String followersCount = widget.user.followersCount.toString();
    String followingsCount = widget.user.followingsCount.toString();
    String postCount = widget.user.postCount.toString();


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
                backgroundImage: widget.user.profileImageURL == null || widget.user.profileImageURL == '' ?  AssetImage('assets/images/profile.jpeg') :  widget.user.profileImageURL != null ? NetworkImage(widget.user.profileImageURL) : AssetImage('assets/images/profile.jpeg') ,
               // backgroundImage: widget.userMap['profileImageURL'] == null || widget.userMap['profileImageURL'] == '' ?  AssetImage('assets/images/profile.jpeg') :   NetworkImage(widget.userMap['profileImageURL']),
                backgroundColor: Colors.transparent,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text(postCount), Text('Posts')],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text(followersCount), Text('Followers')],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text(followingsCount), Text('Following')],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: widget.user.name == null || widget.user.name == '' ? Text('Name') : Text(widget.user.name),

          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
            ),

            child:widget.user.bio == null || widget.user.bio == '' ? Text('Bio') : Text(widget.user.bio),

           
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
           isMe == null ? Container() : isMe ?
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
          ) :Row(
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
        ],
      ),
    );
  }
}
