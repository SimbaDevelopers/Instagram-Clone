import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';

class FollowerListTile extends StatefulWidget {

  final String followersId , userId;
  FollowerListTile({this.followersId , this.userId});
  @override
  _FollowerListTileState createState() => _FollowerListTileState();
}

class _FollowerListTileState extends State<FollowerListTile> {
  String username , name , profileImageURL ;
  bool isFollowing;
  UserModel currentUser;
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Firestore.instance.collection('users').document(widget.followersId).get().then((value) {
      print('value');
      print(widget.followersId);
      setState(() {
        currentUser = Provider.of<UserInformation>(context , listen: false).user;
        username = value['username'];
        name = value['name'];
        profileImageURL = value['profileImageURL'];
        isFollowing = currentUser.followingsMap.containsKey(widget.followersId);
      });
    });
}
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: profileImageURL ==null || profileImageURL == '' ?  AssetImage(
                  'assets/images/profile.jpeg',
                ) : NetworkImage(profileImageURL),
                radius: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: name == null ? Text("") : Text(name),
                  ),
                   username == null ? Text('') : Text(username)
                ],
              ),
              Spacer(),
              currentUser == null ? SizedBox() : currentUser.userId == widget.userId ?
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
                  if(isFollowing){
                    Provider.of<UserInformation>(context , listen: false).unfollow(widget.followersId);
                    setState(() {
                      isFollowing = !isFollowing;
                    });
                  }else{
                    Provider.of<UserInformation>(context , listen: false).addFollowings(widget.followersId);
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
              ) : SizedBox(),
            ],
          ),
        ),
        Divider(color: Colors.blueGrey,)
      ],
    );
  }
}
