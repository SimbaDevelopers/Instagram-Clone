

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import './CloseFriendsSuggetionsListTile.dart';

class CloseFriendsSearchTab extends StatefulWidget  {

  @override
  _CloseFriendsSearchTabState createState() => _CloseFriendsSearchTabState();
}

class _CloseFriendsSearchTabState extends State<CloseFriendsSearchTab> with AutomaticKeepAliveClientMixin<CloseFriendsSearchTab> {
  String userId;
  var stream;
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        userId = value.uid;
        stream = Firestore.instance.collection('users').document(userId).snapshots();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    stream = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return userId == null ? Container() : StreamBuilder(
      stream:  stream,
      builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) return Center(child: CircularProgressIndicator(),);

        if(snapshot.data['followingsMap'] == {} || snapshot.data['followingsMap'] == null)
          return Container();

        List<String> followingList = [];
        snapshot.data['followingsMap'].forEach((k,v) {
          followingList.add(k);
        });
        return ListView.builder(itemCount : followingList.length,
            itemBuilder: (ctx , index){
              if(!snapshot.data['closeFriendsMap'].containsKey(followingList[index])){
                return CloseFriendsSuggetionsListTile(followingsId: followingList[index], userId: userId,);
              }
              else
                return SizedBox(height: 0, width: 0,);
            });
      },
    );

//    return
//      widget.user.followingsCount == 0 ? Container() : ListView.builder(itemCount : widget.user.followingsCount,
//        itemBuilder: (ctx , index){
//          if(!widget.user.closeFriendsMap.containsKey(widget.user.followingList[index]['userId']))
//            return CloseFriendsSuggetionsListTile(followingsId: widget.user.followerList[index]['userId'], userId: widget.user.userId,);
//          else
//            return SizedBox(height: 0, width: 0,);
//        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
