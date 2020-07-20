import 'package:flutter/material.dart';

import '../Activity.dart';
import '../Add.dart';
import '../Home.dart';
import '../Profile.dart';
import '../Search.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
              icon: Icon(Icons.work),
              title: Text(''),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.landscape),
              title: Text(''),
              backgroundColor: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
