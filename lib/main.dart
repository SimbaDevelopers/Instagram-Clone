import 'package:flutter/material.dart';

import 'Add.dart';
import './Home.dart';
import 'Activity.dart';
import './Profile.dart';
import './Search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
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
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            iconSize: 30,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
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
        ));
  }
}
