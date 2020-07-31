import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/FollowersFollowingsScreen.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:instagram/widgets/EditProfile.dart';
import 'package:instagram/widgets/followingBottomSheet.dart';
import 'package:provider/provider.dart';

import '../helper/helpfunction.dart';

class InfoAtProfile extends StatefulWidget {

  UserModel user;


  InfoAtProfile({this.user});
  @override
  _InfoAtProfileState createState() => _InfoAtProfileState();
}

class _InfoAtProfileState extends State<InfoAtProfile> {


  bool isMe  ;
  bool isFollowing;
  UserModel currentUser;
  String followingsCount ;
  String followersCount  ;
  String postCount       ;
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
          return FollowingBottmSheet(user: widget.user,decreaseFollowingsCount:decreaseFollowingsCount);
        });
  }

  decreaseFollowingsCount(){
    setState(() {
      widget.user.followersCount --;
    });
  }
  follow() async {
    print( ' in follow()');
    await Provider.of<UserInformation>(context , listen: false ).addFollowings(widget.user.userId);
    setState(() {
      widget.user.followersCount ++;
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

     followersCount = widget.user.followersCount.toString();
     followingsCount = widget.user.followingsCount.toString();
     postCount = widget.user.postCount.toString();

    currentUser =  Provider.of<UserInformation>(context ).user;
    if(currentUser.followingsMap.containsKey(widget.user.userId))
    {
        isFollowing = true;
    }else {

        isFollowing = false;
    }



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
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed(FollowersFollowingsScreen.routeName  , arguments: {
                    'user' : widget.user,
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Text(followersCount), Text('Followers')],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed(FollowersFollowingsScreen.routeName  , arguments: {
                    'user' : widget.user,
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Text(followingsCount), Text('Following')],
                ),
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
                     isFollowing ?
                     followingButtonPressed(context): follow();
                   },
                   child: isFollowing ? Text(
                     ' Following ▼ ',
                     style: TextStyle(fontSize: 13),
                   ) : Text(
                     ' Follow ',
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
