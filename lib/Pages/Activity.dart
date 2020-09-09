import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  var currentUserSnapshot;
  var stream;
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.currentUser().then((user) async {
      currentUserSnapshot = await Firestore.instance.collection('users').document(user.uid).get();
      setState(() {
        stream = Firestore.instance.collection('feeds').document(user.uid).collection('feedItems').orderBy('timeStamp' , descending: true).limit(20).snapshots();
      });

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Activity'),
        ),
        body: stream == null ? LinearProgressIndicator() : StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) return Center( child: CircularProgressIndicator(),);
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (ctx, index) {

                  return ActivityListTile(
                      activityMap: snapshot.data.documents[index].data, currentUserSnapshot: currentUserSnapshot , key: UniqueKey(),);
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


