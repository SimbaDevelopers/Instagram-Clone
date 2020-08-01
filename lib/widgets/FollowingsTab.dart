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
//  Future _loadingFollowings;
//  Future loadFollowings() async {
//    return await Firestore.instance.collection('users').getDocuments();
//  }

  @override
  void initState() {
//    _loadingFollowings = loadFollowings(); // only create the future once.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.user.followingsCount == 0 ? Container() : ListView.builder( itemCount : widget.user.followingsCount,
        itemBuilder: (ctx , index){
      print(widget.user.followingList[index]['userId']);
          return FollowingListTile(followingsId: widget.user.followingList[index]['userId'], userId: widget.user.userId,);
        } );
  }
}
