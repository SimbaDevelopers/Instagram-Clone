import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/PostList.dart';
import 'package:provider/provider.dart';

class CommentListTile extends StatefulWidget {
  final Map commentsMap;

  final UserModel user;

  final String postId;
  final String ownerId;
  final String title;
  Function undoComment;
  int index;

  CommentListTile(
      {this.commentsMap,
      this.user,
      this.postId,
      this.ownerId,
      this.index,
        this.undoComment,
      Key key,
      this.title})
      : super(key: key);

  @override
  _CommentListTileState createState() => _CommentListTileState(
      commentsMap: commentsMap, user: user, postId: postId, ownerId: ownerId);
}

class _CommentListTileState extends State<CommentListTile> {
  Map commentsMap;

  UserModel user;

  String postId;
  String ownerId;

  _CommentListTileState(
      {this.commentsMap, this.user, this.postId, this.ownerId});

  String profileImageURL;
  String username;
  String name;

  bool isLiked = false;
  bool isDeleting = false;
  bool delete;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    await Firestore.instance
        .collection('users')
        .document(commentsMap['userId'])
        .get()
        .then((value) {
          if(this.mounted) {
            setState(() {
              profileImageURL = value['profileImageURL'];
              username = value['username'];
              name = value['name'];
//              print('=====------>> ' + name);
            });
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        commentsMap['userId'] == user.userId ?
        Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.only(right: 20),
            width: double.infinity,
            color: Colors.blueGrey,
            child: Icon(
              Icons.delete,
              size: 25,
            ),
            alignment: Alignment.centerRight,
          ),
          onDismissed: (direction) async {

            if (commentsMap['userId'] == user.userId) {
              await Provider.of<PostList>(context, listen: false).deleteComment(
                  commentsMap['commentId'], postId,
                  ownerId: ownerId);
                await widget.undoComment(commentsMap , postId);
            }
          },
          child: ListTile(
            key: UniqueKey(),
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
                            TextSpan(text: "  :  ${commentsMap['comment']}"),
                          ]),
                        ),
                      ),
                    ],
                  ),
            subtitle: name == null || name == '' ? Text('') : Text(name),
            trailing: GestureDetector(
              onTap: () async {
              },
              child: Icon(
                          Icons.delete_sweep,
                          size: 20,
                        )
                   ),
          ),
        )
            : ListTile(
          key: UniqueKey(),
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
                    TextSpan(text: "  :  ${commentsMap['comment']}"),
                  ]),
                ),
              ),
            ],
          ),
          subtitle: name == null || name == '' ? Text('') : Text(name),
          trailing: GestureDetector(
            onTap: () async {

                setState(() {
                  isLiked = !isLiked;
                });

            },
            child: isLiked
                ? Icon(
              Icons.favorite,
              color: Colors.red,
              size: 22,
            )
                : Icon(
              Icons.favorite_border,
              color: Colors.red,
              size: 20,
            ),
          ),
        ),


        Divider(),
      ],
    );
  }
}
