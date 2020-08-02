
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import './CloseFriendsListTile.dart';

class CloseFriendsTab extends StatefulWidget {

  UserModel user;
  CloseFriendsTab({this.user});
  @override
  _CloseFriendsTabState createState() => _CloseFriendsTabState();
}

class _CloseFriendsTabState extends State<CloseFriendsTab>  with AutomaticKeepAliveClientMixin<CloseFriendsTab>{
  @override
  Widget build(BuildContext context) {
    return  widget.user.closeFriendsCount == 0 ? Container() : ListView.builder(itemCount : widget.user.closeFriendsCount,
        itemBuilder: (ctx , index){
            return CloseFriendsListTile(closeFriendsId: widget.user.closeFriendsList[index]['userId'], userId: widget.user.userId,);
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
