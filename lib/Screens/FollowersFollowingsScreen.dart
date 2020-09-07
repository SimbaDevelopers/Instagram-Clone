import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/FollowersTab.dart';
import '../widgets/FollowingsTab.dart';

class FollowersFollowingsScreen extends StatefulWidget {
  static const routeName = '/FollowersFollowingsScreen';
  @override
  _FollowersFollowingsScreenState createState() => _FollowersFollowingsScreenState();
}
class _FollowersFollowingsScreenState extends State<FollowersFollowingsScreen> {
  String userId;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if(arguments != null)
        userId = arguments['userId'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder(
            future: Firestore.instance.collection('users').document(userId).get(),
            builder:(cotext , snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData)
                return Text("");
              if(snapshot.data['username']==null || snapshot.data['username'] =='' )
                return Text('');
              return Container(
                child:  Text(snapshot.data['username']),
              );

            }),
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
            FollowersTab(  userId:  userId,),
            FollowingsTab( userId:  userId,),
          ],
        ),
      ),
    );
  }
}
