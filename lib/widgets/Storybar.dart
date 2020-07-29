import 'package:flutter/material.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/helper/helpfunction.dart';

class StoryBar extends StatefulWidget {


  @override
  _StoryBarState createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {

  String _profileImage;

  getUserInfo() async {

     HelperFunction.getProfileImageUrlSharedPreference().then((value) {

       setState(() {
         _profileImage = value;
       });
     });
  }

  @override
  void initState() {
    getUserInfo();
    // TODO: implement initState
    super.initState();
  }
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
            backgroundImage: _profileImage == null ?  AssetImage('assets/images/profile.jpeg') :NetworkImage(_profileImage), //AssetImage('assets/images/profile.jpeg'),
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
