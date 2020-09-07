
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';

class CloseFriendsListTile extends StatefulWidget {
  final String closeFriendsId , userId;
  CloseFriendsListTile({this.closeFriendsId , this.userId});
  @override
  _CloseFriendsListTileState createState() => _CloseFriendsListTileState();
}

class _CloseFriendsListTileState extends State<CloseFriendsListTile> {
  String username , name , profileImageURL ;
  bool isCloseFriend = true;

  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Firestore.instance.collection('users').document(widget.closeFriendsId).get().then((value) {
      setState(() {
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
              if(isCloseFriend){
                Provider.of<UserInformation>(context , listen: false).removeCloseFriend(widget.closeFriendsId);
                setState(() {
                  isCloseFriend = !isCloseFriend;
                });
              }
              else{
                Provider.of<UserInformation>(context , listen: false).addCloseFriend(widget.closeFriendsId);
                setState(() {
                  isCloseFriend = !isCloseFriend;
                });
              }
            },
            child: isCloseFriend == null ? Text('',style: TextStyle(fontSize: 13),) : isCloseFriend ? Text(
              ' Remove ' ,
              style: TextStyle(fontSize: 13),
            ) : Text(
              ' Add ' ,
              style: TextStyle(fontSize: 13),
            ),
        ),
            ],
          ),
        ),
        Divider(color: Colors.blueGrey,),
      ],
    );
  }
}
