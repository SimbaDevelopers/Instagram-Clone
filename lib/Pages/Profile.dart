import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:instagram/widgets/PostAtProfile.dart';
import 'package:instagram/widgets/SettingsDrawer.dart';
import 'package:instagram/widgets/StoryHighlite.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../widgets/InfoAtProfile.dart';
import 'bottom_nav.dart';

void main() => runApp(ProfilePage());

class ProfilePage extends StatefulWidget {
  static const routeName = '/ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map arguments;
  String userId ;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<UserInformation>(context, listen: false).getUserInfo();
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Provider.of<UserInformation>(context, listen: false).getUserInfo();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      userId = arguments['userId'];
    }

    if (arguments == null)
      if(userId == null)
        FirebaseAuth.instance.currentUser().then((user) {
          setState(() {
            print('userId  == set');
            userId = user.uid;
          });
        });

    return Scaffold(
      appBar: new AppBar(
        title:userId ==null ? Text(""): FutureBuilder(
          future: Firestore.instance.collection('users').document(userId).get(),
          builder: (context , snapshot){
            if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData)
              return Text("");
            return Text(snapshot.data['username']);
          },
        ),
      ),
      endDrawer:SettingsDrawer(),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              userId == null
                  ? Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Center(child: CircularProgressIndicator()))
                  : arguments == null
                      ? InfoAtProfile(
                          isMe: true,
                          userId: userId,
                        )
                      : InfoAtProfile(
                          isMe: false,
                          userId: userId,
                        ),

              StoryHighights(),
              PostAtProfile(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation('ProfilePage', context),
    );
  }
}
