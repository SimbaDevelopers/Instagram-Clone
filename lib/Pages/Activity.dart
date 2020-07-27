import 'package:flutter/material.dart';

import 'Add.dart';
import 'Home.dart';
import 'Profile.dart';
import 'Search.dart';
import 'bottom_nav.dart';

void main() => runApp(ActivityPage());

class ActivityPage extends StatelessWidget {
  static const routeName = '/ActivityPage';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Activity'),

        ),
        bottomNavigationBar: BottomNavigation('ActivityPage' , context),
//        bottomNavigationBar:Padding(
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
//                },
//                child: Icon(Icons.favorite_border, size: 35,color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(ProfilePage.routeName);
//                },
//                child: Icon(Icons.supervised_user_circle, size: 35,color: Colors.grey,),
//              ),
//
//            ],
//          ),
//        ),
      ),
    );
  }
}
