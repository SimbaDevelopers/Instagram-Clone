
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';
class FollowingListTile extends StatefulWidget {
  final String followingsId , userId;
  FollowingListTile({this.followingsId , this.userId});
  @override
  _FollowingListTileState createState() => _FollowingListTileState();
}

class _FollowingListTileState extends State<FollowingListTile> {
  String username , name , profileImageURL ;
//  UserModel currentUser;

  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Firestore.instance.collection('users').document(widget.followingsId).get().then((value) {
      print('value');
      print(widget.followingsId);
      setState(() {
//        currentUser = Provider.of<UserInformation>(context , listen: false).user;
        username = value['username'];
        name = value['name'];
        profileImageURL = value['profileImageURL'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
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
//        currentUser == null ? SizedBox() : currentUser.userId == widget.userId ?
//        FlatButton(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(5.0),
//                side: BorderSide(color: Colors.deepPurple[400])),
//            color: Colors.deepPurple[400],
//            textColor: Colors.white,
//            disabledColor: Colors.grey,
//            disabledTextColor: Colors.black,
//            padding: EdgeInsets.all(7),
//            splashColor: Colors.blueAccent,
//            onPressed: () {},
//            child: isFollowing == null ? Text('',style: TextStyle(fontSize: 13),) : isFollowing ? Text(
//              ' Following ' ,
//              style: TextStyle(fontSize: 13),
//            ) : Text(
//              ' Follow ' ,
//              style: TextStyle(fontSize: 13),
//            )
//        ) : SizedBox(),
            ],
          ),
        ),
        Divider(color: Colors.blueGrey,),
      ],
    );
  }
}
