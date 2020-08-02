import 'package:flutter/material.dart';
import '../Pages/Home.dart';

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
  }
}
