import 'package:flutter/material.dart';
import 'package:instagram/Chats/chat.dart';
import 'package:instagram/Pages/bottom_nav.dart';

import '../Pages/Activity.dart';
import '../Pages/Add.dart';
import '../Pages/Home.dart';
import '../Pages/Profile.dart';
import '../Pages/Search.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 // var _pages = [MainScreenX(), Chats()];

  @override
  Widget build(BuildContext context) {
    return HomePage();

//      Scaffold(
//      body:
//      PageView(
//        children: _pages,
//      ),
//    );
  }
}
