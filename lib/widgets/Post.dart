import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/SplashScreen.dart';

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 570,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.white,
      //   ),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.supervised_user_circle,
                      size: 35,
                    ),
                  ),
                  Text('Username'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Center(
              child: Text('Image/Video'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        final FirebaseUser user =
                            await FirebaseAuth.instance.currentUser();
                        print(user.uid.toString());
                      },
                      child: Icon(
                        Icons.favorite,
                        size: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()));
                      },
                      child: Icon(
                        Icons.mode_comment,
                        size: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.send,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.bookmark,
                  size: 30,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  size: 20,
                ),
                Text('  Liked by Tejas and 8,768 others'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 6),
            child: Text(
              'View all 200 comments ',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: Text(
              '2 minutes ago.. ',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.supervised_user_circle,
                  size: 35,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Add a comment....',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
