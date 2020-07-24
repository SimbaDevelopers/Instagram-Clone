import 'package:flutter/material.dart';

import '../Pages/Activity.dart';
import '../Pages/Add.dart';
import '../Pages/Home.dart';
import '../Pages/Profile.dart';
import '../Pages/Search.dart';

class MainScreenX extends StatefulWidget {
  static const routeName = '/MainScreen';
  @override
  _MainScreenXState createState() => _MainScreenXState();
}

class _MainScreenXState extends State<MainScreenX> {
  int _currentIndex = 0;
  final tabs = [
    HomePage(),
    SearchPage(),
    AddPage(),
    ActivityPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(''),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(''),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text(''),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text(''),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              title: Text(''),
              backgroundColor: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            if (index == 2) {
              Navigator.of(context).pushNamed(AddPage.routeName);
            } else {
              _currentIndex = index;
            }
          });
        },
      ),
    );
  }
}
