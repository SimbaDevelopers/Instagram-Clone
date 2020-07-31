
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';

import './FollowerListTile.dart';


class FollowersTab extends StatefulWidget  {

  final UserModel user;
  FollowersTab({this.user});
  @override
  _FollowersTabState createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab> with AutomaticKeepAliveClientMixin<FollowersTab> {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

//  Future _loadingFollowers;
//  Future loadFollowers() async {
//    return await Firestore.instance.collection('users').getDocuments();
//  }

  @override
  void initState() {
//    _loadingFollowers = loadFollowers(); // only create the future once.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  widget.user.followersCount == 0 ? Container() : ListView.builder(itemCount : widget.user.followersCount,
        itemBuilder: (ctx , index){
        return FollowerListTile(followersId: widget.user.followerList[index]['userId'], userId: widget.user.userId,);
        });
  }


}
