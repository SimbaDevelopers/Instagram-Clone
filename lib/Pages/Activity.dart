import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';
import '../widgets/ActivityListTile.dart';

import 'bottom_nav.dart';

void main() => runApp(ActivityPage());

class ActivityPage extends StatefulWidget {
  static const routeName = '/ActivityPage';

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {

  UserModel currentUser;
  var stream;
  @override
  void initState() {
    // TODO: implement initState
    currentUser = Provider.of<UserInformation>(context , listen:  false ).user;
    stream = Firestore.instance.collection('feeds').document(currentUser.userId).collection('feedItems').orderBy('timeStamp' , descending: true).limit(20).snapshots();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Activity'),
        ),
        body: currentUser== null ? LinearProgressIndicator() : StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) return Center( child: CircularProgressIndicator(),);
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (ctx, index) {

                  return ActivityListTile(
                      activityMap: snapshot.data.documents[index].data, user: currentUser , key: UniqueKey(),);
                });
          },
        ),
        bottomNavigationBar: BottomNavigation('ActivityPage' , context),
    );


  }

  @override
  void dispose() {
    stream =null;
    // TODO: implement dispose
    super.dispose();
  }
}


