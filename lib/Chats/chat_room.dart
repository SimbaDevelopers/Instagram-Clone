import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Chats/chat_details.dart';
import 'package:instagram/Chats/messages.dart';
import 'package:instagram/helper/app_constants.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/main.dart';
import 'package:instagram/services/database.dart';
import 'package:provider/provider.dart';

import 'constant_chat.dart';
import 'database_chat.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String currentUserId = "";
  String toUserId = "";
  DataBaseService dataBaseService = new DataBaseService();

  final TextEditingController _textMessageController = TextEditingController();
  bool _isComposing = false;

  DataBaseService _dataBaseService;

  @override
  @override
  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.black,
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 25.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(15.0),
          ),
          Expanded(
            child: TextField(
              controller: _textMessageController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                hintText: 'Type your message...',
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: _isComposing
                ? () => _handleSubmitted(_textMessageController.text)
                : null,
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
  //  FocusScope.of(context).unfocus();
    DateTime _currentdate = new DateTime.now();
    _textMessageController.clear();

    setState(() {
      _isComposing = false;
    });
    FirebaseAuth.instance.currentUser().then((user) {
        Constants.uid = user.uid;

//      Map<String, String> userInfoMap = {
//        "senderId": user.uid,
//        "toUserId": widget.post.data["userId"],
//        "text": text,
//        "timestamp": '$_currentdate',
//      };
//      dataBaseService.sendChatMessage(userInfoMap);

    Firestore.instance.collection('chat_room').add({
        "senderId": user.uid,
        "toUserId": widget.post.data["userId"],
        "text": text,
        "timestamp": Timestamp.now(),
    });      print(widget.post.data["profileImageURL"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  right: 0,

              ),
              child: CircleAvatar(
                  backgroundImage:(widget.post.data["profileImageURL"])==null? AssetImage('assets/images/profile.jpeg') : NetworkImage((widget.post.data["profileImageURL"]))
              ),
            ),
          ],
        ),actions: <Widget>[
          Container(
                margin: EdgeInsets.only(
             top: 12),
               child:widget.post.data["name"]!=null ?Text(widget.post.data["name"]) : Text(""),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            child:Text(widget.post.data["username"]),
          ),
        Container(
          margin: EdgeInsets.only(
            left:15
          ),
          child:
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.video_call,
              color: Colors.white,
              size: 25.0,
            ),
          ),
        ),

        RawMaterialButton(
          onPressed: () =>ChatDetails(),
          child: Icon(
            Icons.details,
            color: Colors.white,
            size: 25.0,
          ),
        )
      ],
      ),

      body: Container(
        child: Column(
          children: <Widget>[
           Expanded(
             child: Messages(widget.post.data["userId"],
                 widget.post.data["profileImageURL"]),
           ),
            _buildMessageComposer(),
          ],
        ),
      ),

    );
  }
}
