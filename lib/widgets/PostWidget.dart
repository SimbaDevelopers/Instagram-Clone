import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instagram/Screens/SplashScreen.dart';
import 'package:instagram/model/Post.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';

class PostWidget extends StatefulWidget {
  Post _documentSnapshot;
  Function sendPost;

  var time = '';


  PostWidget(doc  , sendPost)  {
    _documentSnapshot = doc;
    this.sendPost = sendPost;

   // print(_documentSnapshot.profileImageURL);
    // print(_documentSnapshot['createdAt'].toDate());
    time = displayTimeAgoFromTimestamp(
        _documentSnapshot.timeStamp.toDate().toString());
  }



  String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? 's' : '';

    return timeAgo + ' ago';
  }

  //  getTime(_documentSnapshot['createdAt']);
//    DateTime timeStamp = _documentSnapshot['createdAt'] ;
//
//    var now = DateTime.now();
//    var format = DateFormat('HH:mm a');
//    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp.millisecondsSinceEpoch * 1000);
//    var diff = now.difference(date);
//
//
//    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
//      time = format.format(date);
//    } else if (diff.inDays > 0 && diff.inDays < 7) {
//      if (diff.inDays == 1) {
//        time = diff.inDays.toString() + ' DAY AGO';
//      } else {
//        time = diff.inDays.toString() + ' DAYS AGO';
//      }
//    } else {
//      if (diff.inDays == 7) {
//        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
//      } else {
//
//        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
//      }
//    }

  getTime(int timeStamp) {}

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {

  bool isLiked = false;
  bool isBookmarked = false;
  String profileImageURL;
  String username;

  @override
  void initState() {
    getUsernameAndProfileURl();
    // TODO: implement initState
    super.initState();
  }

  getUsernameAndProfileURl() async {
    Firestore.instance.collection('users').document(widget._documentSnapshot.userId).get().then((value) {
      setState(() {
        profileImageURL = value['profileImageURL'].toString();
        username = value['username'];

      });


    });

//    print('ds["username"] : ' + ds['profileImageURL'].toString());
//    print('usename : ' + ds['username'] );
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Column(
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
                  child:
                      CircleAvatar(
                  backgroundImage: profileImageURL == null || profileImageURL == '' ? AssetImage('assets/images/profile.jpeg') : NetworkImage(profileImageURL),
                  backgroundColor: Colors.grey,
                  )
           ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     username == null ? Text('') :Text(username),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 4),
                      child: Text(
                        widget._documentSnapshot.location,
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ),
                  ],
                ),
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
        InkWell(
          onDoubleTap: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget._documentSnapshot.postURL),
                fit: BoxFit.fill,
              ),
              border: Border.all(
                color: Colors.white,
              ),
            ),
//          child: Center(
//            child: Text('Image/Video'),
//          ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: isLiked
                        ? Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 30,
                          )
                        : Icon(
                            Icons.favorite_border,
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
                  child: InkWell(
                    onTap: (){
                      widget.sendPost();
                    },
                    child: Icon(
                      Icons.send,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                },
                child: isBookmarked
                    ? Icon(
                        Icons.bookmark,
                        size: 30,
                        color: Colors.blueAccent,
                      )
                    : Icon(
                        Icons.bookmark_border,
                        size: 30,
                      ),
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
            widget._documentSnapshot.caption,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13, top: 6),
          child: Text(
            'View all 200 comments ',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 5, bottom: 8),
              child: Icon(
                Icons.supervised_user_circle,
                size: 35,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Add a comment....',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      // ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.grey, width: 0),
                      // ),
                      ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, top: 0),
          child: Text(
            widget.time,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
        Divider(),
//        widget.isLast ? Column(
//          children: <Widget>[
//            Divider(
//              height: 20,
//              color: Colors.white,
//            ),
//            SizedBox(height: 20,),
//            InkWell(
//              onTap: widget.refreshPosts,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Icon(Icons.refresh ,
//                    size: 40,),
//                  Text('refresh Posts')
//
//                ],
//              ),
//            ),
//            SizedBox(height: 20,),
//          ],
//        ) : Container(),
      ],
    );
  }
}
