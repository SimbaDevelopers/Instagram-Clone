import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';

import './FollowerListTile.dart';

class FollowersTab extends StatefulWidget {
  String userId;
  FollowersTab({ this.userId});
  @override
  _FollowersTabState createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab>
    with AutomaticKeepAliveClientMixin<FollowersTab> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document(widget.userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        List<String> followersList = [];
        snapshot.data['followersMap'].forEach((k,v) {
          if(snapshot.data['userId'] != k)
          followersList.add(k);
        });
        return ListView.builder(
            itemCount: followersList.length,
            itemBuilder: (ctx, index) {
              return FollowerListTile(
                followersId: followersList[index],
                userId: widget.userId,
              );
            });
      },
    );
  }
}
