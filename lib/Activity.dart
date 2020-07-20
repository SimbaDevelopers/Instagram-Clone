import 'package:flutter/material.dart';

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
      ),
    );
  }
}
