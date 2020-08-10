 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';


class LikesTile extends StatefulWidget {
  String likerId;
  UserModel user;
  LikesTile({this.likerId , this.user});
  @override
  _LikesTileState createState() => _LikesTileState(likerId : this.likerId , user : user);
}

class _LikesTileState extends State<LikesTile> {
  String likerId;
  UserModel user;
  _LikesTileState({this.likerId , this.user});
  String profileImageURL;
  String username;
  String name;
  bool isFollowing;

  @override
  void initState() {
      getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    await Firestore.instance.collection('users').document(likerId).get().then((value) {
      if(this.mounted)
      setState(() {
        profileImageURL = value['profileImageURL'];
        username = value['username'];
        name = value['name'];
        isFollowing = user.followingsMap.containsKey(likerId);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      key: UniqueKey(),
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: profileImageURL == null || profileImageURL == ''
                ? AssetImage('assets/images/profile.jpeg')
                : NetworkImage(profileImageURL),
            backgroundColor: Colors.grey,
          ),
          title: username == null ? Text('username') : Text(username),
          subtitle:name == null ? Text('') : Text(name),
          trailing:FlatButton(
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
                if(isFollowing){
                  Provider.of<UserInformation>(context , listen: false).unfollow(likerId);
                  setState(() {
                    isFollowing = !isFollowing;
                  });
                }else{
                  Provider.of<UserInformation>(context , listen: false).addFollowings(likerId);
                  setState(() {
                    isFollowing = !isFollowing;
                  });

                }
              },
              child: isFollowing == null ? Text('',style: TextStyle(fontSize: 13),) : isFollowing ? Text(
                ' Following ' ,
                style: TextStyle(fontSize: 13),
              ) : Text(
                ' Follow ' ,
                style: TextStyle(fontSize: 13),
              )
          ),
        ),
        Divider(),
      ],
    );
  }
}
