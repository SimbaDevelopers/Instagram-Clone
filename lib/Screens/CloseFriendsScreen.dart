
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import '../widgets/CloseFriendsTab.dart';
import '../widgets/CloseFriendsSearchTab.dart';

class CloseFriendsScreen extends StatefulWidget {
  static const routeName = '/Signup';
  @override
  _CloseFriendsScreenState createState() => _CloseFriendsScreenState();
}

class _CloseFriendsScreenState extends State<CloseFriendsScreen> {

  @override
  Widget build(BuildContext context) {
    var  arguments = ModalRoute.of(context).settings.arguments as Map;
    UserModel user = arguments['user'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Close Friends'),
          bottom: TabBar(
            tabs: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Close Friends'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Suggestions'),
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            CloseFriendsTab( user : user),
            CloseFriendsSearchTab(user : user),
          ],
        ),
      ),
    );
  }
}
