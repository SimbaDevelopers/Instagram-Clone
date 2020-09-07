
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import './CloseFriendsListTile.dart';

class CloseFriendsTab extends StatefulWidget {

  @override
  _CloseFriendsTabState createState() => _CloseFriendsTabState();
}

class _CloseFriendsTabState extends State<CloseFriendsTab>  with AutomaticKeepAliveClientMixin<CloseFriendsTab>{
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
    
    return userId == null ? Container() : StreamBuilder(
      stream: stream,
      builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) return Center(child: CircularProgressIndicator(),);

        if(snapshot.data['closeFriendsMap'] == {} || snapshot.data['closeFriendsMap'] == null)
          return Container();

        List<String> closeFriendsList = [];
        snapshot.data['closeFriendsMap'].forEach((k,v) {
          closeFriendsList.add(k);
        });
        return ListView.builder(itemCount : closeFriendsList.length,
            itemBuilder: (ctx , index){
              return CloseFriendsListTile(closeFriendsId: closeFriendsList[index], userId:userId,);
            });
      },
    );
//    return  widget.user.closeFriendsCount == 0 ? Container() : ListView.builder(itemCount : widget.user.closeFriendsCount,
//        itemBuilder: (ctx , index){
//            return CloseFriendsListTile(closeFriendsId: widget.user.closeFriendsList[index]['userId'], userId: widget.user.userId,);
//        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
