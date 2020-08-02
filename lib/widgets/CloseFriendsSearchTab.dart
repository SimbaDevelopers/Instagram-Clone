

import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import './CloseFriendsSuggetionsListTile.dart';

class CloseFriendsSearchTab extends StatefulWidget  {

  UserModel user;
  CloseFriendsSearchTab({this.user});
  @override
  _CloseFriendsSearchTabState createState() => _CloseFriendsSearchTabState();
}

class _CloseFriendsSearchTabState extends State<CloseFriendsSearchTab> with AutomaticKeepAliveClientMixin<CloseFriendsSearchTab> {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  widget.user.followingsCount == 0 ? Container() : ListView.builder(itemCount : widget.user.followingsCount,
        itemBuilder: (ctx , index){
          if(!widget.user.closeFriendsMap.containsKey(widget.user.followingList[index]['userId']))
            return CloseFriendsSuggetionsListTile(followingsId: widget.user.followerList[index]['userId'], userId: widget.user.userId,);
          else
            return SizedBox(height: 0, width: 0,);
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
