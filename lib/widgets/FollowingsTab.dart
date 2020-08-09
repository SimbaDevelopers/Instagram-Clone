import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';
import './FollowingListTile.dart';

class FollowingsTab extends StatefulWidget {
  final UserModel user;
  FollowingsTab({this.user});
  @override
  _FollowingsTabState createState() => _FollowingsTabState();
}

class _FollowingsTabState extends State<FollowingsTab> with AutomaticKeepAliveClientMixin<FollowingsTab> {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
      StreamBuilder(
        stream: Firestore.instance.collection('users').document(widget.user.userId).collection('followingsList').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          List<Map> followingsList = [];
          snapshot.data.documents.forEach((doc) {
            followingsList.add(doc.data);
          });
          return ListView.builder(
              itemCount: followingsList.length,
              itemBuilder: (ctx, index) {
                return FollowingListTile(followingsId:followingsList[index]['userId'], userId: widget.user.userId,);
              });
        },
      );
//      widget.user.followingsCount == 0 ? Container() : ListView.builder( itemCount : widget.user.followingsCount,
//        itemBuilder: (ctx , index){
//      print(widget.user.followingList[index]['userId']);
//          return FollowingListTile(followingsId: widget.user.followingList[index]['userId'], userId: widget.user.userId,);
//        } );
  }
}
