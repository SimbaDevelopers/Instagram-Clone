import 'dart:async';

import 'package:animator/animator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/CommentsScreen.dart';

import 'package:instagram/Screens/SplashScreen.dart';
import 'package:instagram/model/Post.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/PostList.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:instagram/services/database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';
import '../Screens/LikesScreen.dart';

class PostWidget extends StatefulWidget {
  Post _documentSnapshot;
  Function sendPost;

  var time = '';

  PostWidget(doc, sendPost) {
    _documentSnapshot = doc;
    this.sendPost = sendPost;
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

  getTime(int timeStamp) {}

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  bool isBookmarked = false;
  String profileImageURL;
  String username;
  List<String> likerName = [];
  UserModel currentUser;
  bool showHeart = false;
  var likeStream;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    getUsernameAndProfileURl();
    currentUser = Provider.of<UserInformation>(context, listen: false).user;
    setState(() {
      isLiked = widget._documentSnapshot.likesMap.containsKey(currentUser.userId);

    });
//    likesThings();
    likeStream = Firestore.instance.collection('posts').document(widget._documentSnapshot.postId).snapshots();
    // TODO: implement initState
    super.initState();
  }
//  likesThings() async {
//    if (widget._documentSnapshot.likesMap == null) {
//      isLiked = false;
//    } else {
//      print('============================================');
//      int i = 0;
//      String likerId;
//      for (var k in widget._documentSnapshot.likesMap.keys) {
//        if (i >= 1) return;
//        likerId = k;
//        i++;
//
//        Firestore.instance
//            .collection('users')
//            .document(likerId)
//            .get()
//            .then((value) {
//          setState(() {
//            likerName.add(value['username']);
//          });
//        });
//      }
//    }
//  }

  getUsernameAndProfileURl() async {
    Firestore.instance
        .collection('users')
        .document(widget._documentSnapshot.userId)
        .get()
        .then((value) {
      setState(() {
        profileImageURL = value['profileImageURL'].toString();
        username = value['username'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: profileImageURL == null || profileImageURL == ''
                ? AssetImage('assets/images/profile.jpeg')
                : NetworkImage(profileImageURL),
            backgroundColor: Colors.grey,
          ),
          title: username == null ? Text('') : Text(username),
          subtitle: Text(
            widget._documentSnapshot.location,
            // style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
          trailing: Icon(Icons.more_vert),
        ),

//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: CircleAvatar(
//                      backgroundImage:
//                          profileImageURL == null || profileImageURL == ''
//                              ? AssetImage('assets/images/profile.jpeg')
//                              : NetworkImage(profileImageURL),
//                      backgroundColor: Colors.grey,
//                    )),
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    username == null ? Text('') : Text(username),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 5.0, top: 4),
//                      child: Text(
//                        widget._documentSnapshot.location,
//                        style: TextStyle(color: Colors.grey, fontSize: 11),
//                      ),
//                    ),
//                  ],
//                ),
//              ],
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Icon(Icons.more_vert),
//            ),
//          ],
//        ),
        Divider(
          color: Colors.white,
        ),
        InkWell(
          onDoubleTap: () async {
            currentUser =
                Provider.of<UserInformation>(context, listen: false).user;

            if (isLiked) {
              if (currentUser.userId == null) {
                setState(() {
                  isLiked = !isLiked;
                });
                return;
              }
              setState(() {
                isLiked = !isLiked;
              });
              //Firestore.instance.collection('posts').document(widget._documentSnapshot.postId).get();
              Provider.of<PostList>(context, listen: false).unlikePost(
                  widget._documentSnapshot.postId,
                  widget._documentSnapshot.likesCount,
                  currentUser.userId,
                  posterId: widget._documentSnapshot.userId);
//              likesThings();
            } else {
              if (currentUser.userId == null) {
                setState(() {
                  isLiked = !isLiked;
                });
                return;
              }
              setState(() {
                isLiked = !isLiked;
                showHeart = true;
              });

              Timer(Duration(milliseconds: 1300), () {
                setState(() {
                  showHeart = false;
                });
              });

              Provider.of<PostList>(context, listen: false).likePost(
                  widget._documentSnapshot.postId,
                  widget._documentSnapshot.likesCount,
                  currentUser.userId);

            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
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
              ),
              showHeart
                  ? Animator(
                      duration: Duration(milliseconds: 900),
                      tween: Tween(begin: 1.0, end: 1.4),
                      curve: Curves.easeInOutCubic,
                      cycles: 0,
                      builder: (ctx, anim, child) => Transform.scale(
                        scale: anim.value,
                        child: Icon(
                          Icons.favorite,
                          size: 60,
                          color: Colors.redAccent,
                        ),
                      ),
                    )
                  : Text(""),
              //showHeart ? Icon(Icons.favorite , size: 80, color:  Colors.red,) : Text(""),
            ],
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
                      currentUser =
                          Provider.of<UserInformation>(context, listen: false).user;

                      if (isLiked) {
                        if (currentUser.userId == null) {
                          setState(() {
                            isLiked = !isLiked;
                          });
                          return;
                        }
                        setState(() {
                          isLiked = !isLiked;
                        });
                        //Firestore.instance.collection('posts').document(widget._documentSnapshot.postId).get();
                        Provider.of<PostList>(context, listen: false)
                            .unlikePost(
                                widget._documentSnapshot.postId,
                                widget._documentSnapshot.likesCount,
                                currentUser.userId,
                                posterId: widget._documentSnapshot.userId);
                      } else {
                        if (currentUser.userId == null) {
                          setState(() {
                            isLiked = !isLiked;
                          });
                          return;
                        }
                        setState(() {
                          isLiked = !isLiked;
                        });
                        Provider.of<PostList>(context, listen: false).likePost(
                            widget._documentSnapshot.postId,
                            widget._documentSnapshot.likesCount,
                            currentUser.userId);

                      }
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
                    onTap: () {
                      widget.sendPost(widget._documentSnapshot.postURL);
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

                  currentUser =
                      Provider.of<UserInformation>(context, listen: false).user;

                  if (isBookmarked) {
                    if (currentUser.userId == null) {
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });
                      return;
                    }
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });
                    Firestore.instance.collection('posts').document(widget._documentSnapshot.postId).get();
                    Provider.of<PostList>(context, listen: false)
                        .unsave(
                        widget._documentSnapshot.postId,
                        currentUser.userId,
                        widget._documentSnapshot.postURL);
                  } else {
                    if (currentUser.userId == null) {
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });
                      return;
                    }
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });
                    Provider.of<PostList>(context, listen: false).saved(
                        widget._documentSnapshot.postId,
                        currentUser.userId,
                        widget._documentSnapshot.postURL);
                  }
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
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(LikesScreen.routeName, arguments: {
                'postId': widget._documentSnapshot.postId,
                'user': currentUser,
              });
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  size: 20,
                ),
                //Text('aiiuhdiahi'),
                StreamBuilder(
                  stream: likeStream,
                  builder: (context , snapshot) {
                    if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) return Text("");
                    List<String> likersList =[] ;
                    int i = 0;
                    snapshot.data['likesMap'].keys.forEach((k) {
                      likersList.add(k);
                    });

                    return Text(" ${snapshot.data['likesCount']} Likes");


//                    Text("Liked By ${snapshot.data['likesCount']} and  ${snapshot.data['likesCount']-1 <=  0 ? "" : snapshot.data['likesCount']-1 } others")
//                      Text(" Liked by ${snapshot.data['likesMap'].length} users");
                  },
                ),
//                widget._documentSnapshot.likesCount == 0
//                    ? Text('  0 likes ')
//                    : likerName.isEmpty
//                        ? Flexible(
//                            child: Text(
//                            'safsdafasdfs',
//                            softWrap: true,
//                          ))
//                        : widget._documentSnapshot.likesCount == 1
//                            ? Flexible(
//                                child: Text(
//                                " Liked by ${likerName[0]}",
//                                softWrap: true,
//                              ))
//                            : widget._documentSnapshot.likesCount > 1
//                                ? Flexible(
//                                    child: Text(
//                                    " Liked by ${likerName[0]} and ${widget._documentSnapshot.likesCount - 1} others ",
//                                    softWrap: true,
//                                  ))
//                                : Text('')
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13, top: 6),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  widget._documentSnapshot.caption,
                  softWrap: true,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13, top: 6),
          child: widget._documentSnapshot.commentsCount == 0
              ? Text(
                  'No comments',
                  style: TextStyle(color: Colors.grey),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(CommentsScreen.routeName, arguments: {
                      'postId': widget._documentSnapshot.postId,
                      'user': currentUser,
                      'ownerId': widget._documentSnapshot.userId,
                    });
                  },
                  child: Text(
                    'View all ${widget._documentSnapshot.commentsCount} comments ',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.supervised_user_circle,
                      size: 30,
                    ),
                    hintText: 'Add a comment....',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (commentController.text != '') {
                          Provider.of<PostList>(context, listen: false)
                              .addComment(widget._documentSnapshot.postId,
                                  currentUser.userId, commentController.text);
                          commentController.text = '';
                        }
                      },
                      child: Icon(
                        Icons.send,
                        size: 25,
                      ),
                    ),
                    border: InputBorder.none,

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
      ],
    );
  }

  @override
  void dispose() {
    likeStream =null;
    // TODO: implement dispose
    super.dispose();
  }

}
