import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';

class ActivityListTile extends StatefulWidget {
  Map activityMap;

  UserModel user;
  String title;

  ActivityListTile({this.activityMap, this.user , this.title  , Key key }) : super (key : key);

  @override
  _ActivityListTileState createState() =>
      _ActivityListTileState(activityMap: activityMap, user: user);
}

class _ActivityListTileState extends State<ActivityListTile> {
  Map activityMap;
  UserModel user;

  _ActivityListTileState({this.activityMap, this.user});

  String profileImageURL;
  String username;
  String name;
  String postURL;

  bool isFollowing;
  bool postExist;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    await Firestore.instance
        .collection('users')
        .document(activityMap['userId'])
        .get()
        .then((value) async {
      isFollowing = user.followingsMap.containsKey(activityMap['userId']);
      profileImageURL = value['profileImageURL'];
      username = value['username'];
      name = value['name'];
      if (activityMap['type'] == 'comment' || activityMap['type'] == 'like') {
        var docSnap = await Firestore.instance
            .collection('posts')
            .document(activityMap['postId'])
            .get();
        if (docSnap.exists) {
          if(this.mounted)
          setState(() {
            postURL = docSnap.data['postURL'];
            postExist = true;
          });
        } else {
          if(this.mounted)
            setState(() {
            postExist = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return postExist == null || postExist == false
        ? SizedBox()
        : activityMap['type'] == 'comment'
            ? buildCommentListTile()
            : activityMap['type'] == 'like'
                ? buildLikeListTile()
                : activityMap['type'] == 'follower'
                    ? buildFollowerListTile()
                    : Container();
  }

  Widget buildFollowerListTile() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: profileImageURL == null || profileImageURL == ''
                ? AssetImage('assets/images/profile.jpeg')
                : NetworkImage(profileImageURL),
            backgroundColor: Colors.grey,
          ),
          title: username == null
              ? Text('')
              : Row(
                  children: <Widget>[
                    Flexible(
                      child: RichText(
                        text: TextSpan(style: TextStyle(), children: [
                          TextSpan(
                              text: username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          TextSpan(
                              text:
                                  "  stated following you. \n ${activityMap['comment']}"),
                        ]),
                      ),
                    ),
                  ],
                ),
          trailing: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.deepPurple[400])),
              color: Colors.deepPurple[400],
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(7),
              splashColor: Colors.blueAccent,
              onPressed: () {
                if (isFollowing) {
                  Provider.of<UserInformation>(context, listen: false)
                      .unfollow(activityMap['userId']);
                  setState(() {
                    isFollowing = !isFollowing;
                  });
                } else {
                  Provider.of<UserInformation>(context, listen: false)
                      .addFollowings(activityMap['userId']);
                  setState(() {
                    isFollowing = !isFollowing;
                  });
                }
              },
              child: isFollowing == null
                  ? Text(
                      '',
                      style: TextStyle(fontSize: 13),
                    )
                  : isFollowing
                      ? Text(
                          ' Following ',
                          style: TextStyle(fontSize: 13),
                        )
                      : Text(
                          ' Follow ',
                          style: TextStyle(fontSize: 13),
                        )),
        ),
        Divider()
      ],
    );
  }

  Widget buildCommentListTile() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: profileImageURL == null || profileImageURL == ''
                ? AssetImage('assets/images/profile.jpeg')
                : NetworkImage(profileImageURL),
            backgroundColor: Colors.grey,
          ),
          title: username == null
              ? Text('')
              : Row(
                  children: <Widget>[
                    Flexible(
                      child: RichText(
                        text: TextSpan(style: TextStyle(), children: [
                          TextSpan(
                              text: username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          TextSpan(text: "  is commented to your photo."),
                        ]),
                      ),
                    ),
                  ],
                ),
          trailing: GestureDetector(
            child: Container(
              width: 40,
              height: 40,
              child: postURL == null
                  ? Icon(
                      Icons.image,
                      size: 30,
                    )
                  : Image.network(postURL),
              alignment: Alignment.center,
            ),
          ),
        ),
        Divider()
      ],
    );
  }

  Widget buildLikeListTile() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: profileImageURL == null || profileImageURL == ''
                ? AssetImage('assets/images/profile.jpeg')
                : NetworkImage(profileImageURL),
            backgroundColor: Colors.grey,
          ),
          title: username == null
              ? Text('')
              : Row(
                  children: <Widget>[
                    Flexible(
                      child: RichText(
                        text: TextSpan(style: TextStyle(), children: [
                          TextSpan(
                              text: username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          TextSpan(text: "  is liked your photo."),
                        ]),
                      ),
                    ),
                  ],
                ),
          trailing: GestureDetector(
            child: Container(
              width: 40,
              height: 40,
//              decoration: BoxDecoration(
//                  border: Border.all(width: 2, color: Colors.grey)),
              child: postURL == null
                  ? Icon(
                      Icons.image,
                      size: 30,
                    )
                  : Image.network(postURL),
              alignment: Alignment.center,
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
