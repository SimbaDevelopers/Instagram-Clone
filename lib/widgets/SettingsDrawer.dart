
import 'package:flutter/material.dart';
//import 'file:///D:/Personal/Personal/Instagram-clone/Instagram-Clone/lib/Settings/SettingScreen.dart';
import '../Settings/SettingScreen.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';
import '../Screens/CloseFriendsScreen.dart';

class SettingsDrawer extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserInformation>(context).user;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 8),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Divider(
              color: Colors.grey,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.history,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Text(
                      'Archive',
                      style: TextStyle(fontSize: 18),
                    )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Your Activity',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.center_focus_weak,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Nametag',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.bookmark_border,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Saved',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.group,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: (){
                        user.userId == null ? print('User == null') :
                        Navigator.of(context).pushNamed(CloseFriendsScreen.routeName , arguments: {
                          'user' : user
                        });
                      },
                      child: Expanded(
                        child: Text(
                          'Close Friends',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person_add,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Discover People',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
//            InkWell(
//              onTap: () async {
////                SharedPreferences preferences =
////                    await SharedPreferences.getInstance();
////                await preferences.clear();
////
////                FirebaseAuth.instance.signOut();
////                Constants.imgpro="";
////
////                Provider.of<UserInformation>(context , listen: false).logout();
////                Provider.of<PostList>(context , listen: false).logout();
////
////                Navigator.pushReplacement(context,
////                    MaterialPageRoute(builder: (ctx) => Authenticate()));
//              },
//              child: Padding(
//                padding: const EdgeInsets.symmetric(vertical: 7.0),
//                child: Row(
//                  children: <Widget>[
//                    Icon(
//                      Icons.exit_to_app,
//                      size: 30,
//                    ),
//                    SizedBox(
//                      width: 15,
//                    ),
//                    Expanded(
//                      child: Text(
//                        'Logout',
//                        style: TextStyle(fontSize: 18),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
            Spacer(),
            Divider(
              color: Colors.grey,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => SettingScreen()));
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
