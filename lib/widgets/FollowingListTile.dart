
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection('users').document(widget.followingsId).get(),
      builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) return Container();
        if(!snapshot.hasData) return SizedBox();
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: snapshot.data['profileImageURL'] ==null || snapshot.data['profileImageURL']  == '' ?  AssetImage(
                      'assets/images/profile.jpeg',
                    ) : NetworkImage(snapshot.data['profileImageURL'] ),
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
                        child: snapshot.data['name']  == null  || snapshot.data['name']  == ''? Text("") : Text(snapshot.data['name'] ),
                      ),
                      snapshot.data['username']  == null ? Text('') : Text(snapshot.data['username'] )
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(color: Colors.blueGrey,),
          ],
        );
      },
    );
  }
}
