import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Chats/chat_room.dart';
import 'package:instagram/Screens/FollowersFollowingsScreen.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:instagram/widgets/EditProfile.dart';
import 'package:instagram/widgets/followingBottomSheet.dart';
import 'package:provider/provider.dart';

class InfoAtProfile extends StatefulWidget {
  String userId;
  bool isMe;
  InfoAtProfile({this.userId ,  this.isMe});
  @override
  _InfoAtProfileState createState() => _InfoAtProfileState();
}
class _InfoAtProfileState extends State<InfoAtProfile> {
  var userStream;
  String currentUserId;
  void followingButtonPressed(context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return FollowingBottmSheet(
              userId: widget.userId,
              );
        });
    setState(() {
    });
  }
  follow() async {
    print(' in follow()');
    await Provider.of<UserInformation>(context, listen: false)
        .addFollowings(widget.userId);
  }
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        currentUserId = value.uid;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    userStream =null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userStream =  Firestore.instance.collection('users').document(widget.userId).snapshots();

    return
      StreamBuilder(
      stream: userStream,
      builder: (context , userSnapshot){
        if(userSnapshot.connectionState == ConnectionState.waiting || !userSnapshot.hasData) return Center(child: CircularProgressIndicator(),);

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
                    backgroundImage: userSnapshot.data['profileImageURL'] == null ||
                        userSnapshot.data['profileImageURL'] == ''
                        ? AssetImage('assets/images/profile.jpeg')
                        : userSnapshot.data['profileImageURL'] != null
                        ? NetworkImage(userSnapshot.data['profileImageURL'])
                        : AssetImage('assets/images/profile.jpeg'),
                    // backgroundImage: widget.userMap['profileImageURL'] == null || widget.userMap['profileImageURL'] == '' ?  AssetImage('assets/images/profile.jpeg') :   NetworkImage(widget.userMap['profileImageURL']),
                    backgroundColor: Colors.transparent,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Text(userSnapshot.data['postCount'].toString()), Text('Posts')],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          FollowersFollowingsScreen.routeName,
                          arguments: {
                            'userId' : widget.userId
                          });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(userSnapshot.data['followersCount'].toString()),
                        Text('Followers'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          FollowersFollowingsScreen.routeName,
                          arguments: {
                            'userId' : widget.userId
                          });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(userSnapshot.data['followingsCount'].toString()),
                        Text('Following'),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: userSnapshot.data['name']== null || userSnapshot.data['name'] == ''
                    ? Text('Name')
                    : Text(userSnapshot.data['name']),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: userSnapshot.data['bio'] == null || userSnapshot.data['bio'] == ''
                    ? Text('Bio')
                    : Text(userSnapshot.data['bio']),
              ),
              widget.isMe == null || currentUserId == null
                  ? Container()
                  : widget.isMe
                  ? FlatButton(
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
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side:
                          BorderSide(color: Colors.deepPurple[400])),
                      color: Colors.deepPurple[400],
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        userSnapshot.data['followersMap'].containsKey(currentUserId)
                            ? followingButtonPressed(context)
                            : follow();
                      },
                      child: userSnapshot.data['followersMap'].containsKey(currentUserId)
                          ? Text(
                        ' Following ▼ ',
                        style: TextStyle(fontSize: 13),
                      )
                          : Text(
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
                          side:
                          BorderSide(color: Colors.deepPurple[400])),
                      color: Colors.deepPurple[400],
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(7),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    null,
                                    userSnapshot.data['name'],
                                    userSnapshot.data['username'],
                                    userSnapshot.data['profileImageURL'],
                                    userSnapshot.data['userId'])));
                      },
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
    );
  }
}


