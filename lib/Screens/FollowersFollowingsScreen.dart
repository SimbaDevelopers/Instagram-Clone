


import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import '../widgets/FollowersTab.dart';
import '../widgets/FollowingsTab.dart';

class FollowersFollowingsScreen extends StatefulWidget {
  static const routeName = '/FollowersFollowingsScreen';
  @override
  _FollowersFollowingsScreenState createState() => _FollowersFollowingsScreenState();
}


class _FollowersFollowingsScreenState extends State<FollowersFollowingsScreen> {
  UserModel user;


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if(arguments != null)
      {
        user = arguments['user'];

      }

    return DefaultTabController(

      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: user == null ? Text('Username') : Text(user.username),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Followers'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Followings'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FollowersTab( user: user),
            FollowingsTab(user : user),
          ],
        ),
      ),
    );

  }
}
