import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/chatuser.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:instagram/widgets/PostAtProfile.dart';
import 'package:instagram/widgets/SettingsDrawer.dart';
import 'package:instagram/widgets/StoryHighlite.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helper/helpfunction.dart';
import '../widgets/InfoAtProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authenticate.dart';
import 'Activity.dart';
import 'Add.dart';
import 'Home.dart';
import 'Search.dart';
import 'bottom_nav.dart';

void main() => runApp(ProfilePage());

class ProfilePage extends StatefulWidget {
  static const routeName = '/ProfilePage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


// String username , name , userId , profileImageURL , bio , website ,email;
// int followingsCount , followersCount , postCount ;
// Map followersMap , followingsMap;
  UserModel user;
  Map arguments;

  UserModel searchedUser;


  getSearchedUser(arguments) async {
    var followingsListSnapshot;
    var followersListSnapshot;
    var closeFriendsListSnapshot;
    List<Map> followingsList = [];
    List<Map> followersList = [];
    List<Map> closeFriendsList = [];

     var docSnap = await Firestore.instance.collection('users').document(arguments['userId']).get();
//     username         = docSnap.data['username'],
//     name             = docSnap.data['userId'],
//     profileImageURL  = docSnap.data['profileImageURL'],
//     name             = docSnap.data['name'],
//     bio              = docSnap.data['bio'],
//     followingsCount  = docSnap.data['followingsCount'],
//     followersCount   = docSnap.data['followersCount'],
//     followersMap     = docSnap.data['followersMap'],
//     followingsMap    = docSnap.data['followingsMap'],
//     email            = docSnap.data['email'],
//     postCount        = docSnap.data['postCount'],

    followingsListSnapshot = await Firestore.instance.collection('users').document(arguments['userId']).collection('followingsList').getDocuments();
    if(followingsListSnapshot.documents.length != 0){
      for (DocumentSnapshot documentSnapshot in followingsListSnapshot.documents) {
        followingsList.add(documentSnapshot.data);
      }
    }

    followersListSnapshot = await Firestore.instance.collection('users').document(arguments['userId']).collection('followersList').getDocuments();
    if(followersListSnapshot.documents.length != 0){
      for (DocumentSnapshot documentSnapshot in followersListSnapshot.documents) {
        followersList.add(documentSnapshot.data);
      }
    }

    closeFriendsListSnapshot = await Firestore.instance.collection('users').document(arguments['userId']).collection('closeFriendsList').getDocuments();
    if(closeFriendsListSnapshot.documents.length != 0){
      for (DocumentSnapshot documentSnapshot in closeFriendsListSnapshot.documents) {
        closeFriendsList.add(documentSnapshot.data);
      }
    }

    setState(() {
      searchedUser = UserModel.fromMap(snapshot: docSnap, followersList: followersList , followingsList:  followingsList , closeFriendsList: closeFriendsList);
    });

  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<UserInformation>(context ,listen: false).getUserInfo();
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

  void _onRefresh() async{
   await  Provider.of<UserInformation>(context , listen: false).getUserInfo();
    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments as Map;
    if(arguments != null && searchedUser == null)
    {
      getSearchedUser(arguments);
      //   searchedUser = UserModel.fromMap(snapshot: arguments, followersList: arguments['followersList'] , followingsList:  arguments['followingsList']);

    }
    if(arguments == null)  {
      user = Provider
          .of<UserInformation>(context)
          .user;
    }


    return
//      new
//      WillPopScope(
//      onWillPop: _onWillPop,
//      child:
//      new
      Scaffold(
        appBar: new AppBar(
          title:  Consumer<UserInformation>(
            builder: (context, userInformation, child) {
            return userInformation.user.username == null ? Text('') : Text(userInformation.user.username);
          },),
        ),
        endDrawer: /*arguments != null ? searchedUser != null ? SettingsDrawer() : Center(child: CircularProgressIndicator()) : user.userId == null ? Center(child: CircularProgressIndicator()):*/ SettingsDrawer() ,


        body: SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,

          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                arguments != null ? searchedUser != null ? InfoAtProfile( user: searchedUser ) : Center(child: CircularProgressIndicator()) : user == null  ? Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Center(child: CircularProgressIndicator()),
                ): InfoAtProfile(user: user,) ,
                StoryHighights(),
                PostAtProfile(),
              ],

            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation('ProfilePage' , context),
//        bottomNavigationBar: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(HomePage.routeName);
//                },
//                child: Icon(Icons.home , size: 35, color: Colors.white,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(SearchPage.routeName);
//                },
//                child: Icon(Icons.search, size: 35, color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(AddPage.routeName);
//                },
//                child: Icon(Icons.add, size: 35,color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(ActivityPage.routeName);
//
//                },
//                child: Icon(Icons.favorite_border, size: 35,color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){},
//                child: Icon(Icons.supervised_user_circle, size: 35,color: Colors.grey,),
//              ),
//
//            ],
//          ),
//        ),
//      ),
    );
  }
}
