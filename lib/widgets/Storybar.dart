import 'package:flutter/material.dart';
import 'package:instagram/helper/constants.dart';

class StoryBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      width: double.infinity,
      height: 100,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 30.0,
            backgroundImage:NetworkImage(Constants.imgpro), //AssetImage('assets/images/profile.jpeg'),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundColor: Colors.brown.shade50,
            radius: 30.0,
            child: Text('TA'),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.brown.shade50,
            child: Text('TA'),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.brown.shade50,
            child: Text('TA'),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.brown.shade50,
            child: Text('TA'),
          ),
        ],
      ),
    );
  }
}
