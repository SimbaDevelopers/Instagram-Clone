import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './FollowingListTile.dart';

class FollowingsTab extends StatefulWidget {
  String userId;
  FollowingsTab({ this.userId});
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
        stream: Firestore.instance.collection('users').document(widget.userId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List<String> followingsList = [];
          snapshot.data['followingsMap'].forEach((k , v) {
            if(snapshot.data['userId'] != k)
              followingsList.add(k);
          });
          print(followingsList);
          return ListView.builder(
              itemCount: followingsList.length,
              itemBuilder: (ctx, index) {
                return FollowingListTile(followingsId:followingsList[index], userId: widget.userId,);
              });
        },
      );
  }
}
