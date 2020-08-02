import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Chats/chat_details.dart';
import 'package:instagram/Chats/messages.dart';
import 'package:instagram/helper/app_constants.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/main.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/services/database.dart';
import 'package:provider/provider.dart';

import 'constant_chat.dart';
import 'database_chat.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  final toimgurl,toname,tousername,touserId;

  DetailPage(this.post,this.toname,this.tousername,this.toimgurl,this.touserId);

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
            onPressed: () async {
         //     print("xxxxxxxxxxxxxxxxxxxxxxxx"+widget.user.name);
              File imageFile = await ImagePicker.pickImage(
                source: ImageSource.gallery,
              );
              if (imageFile != null) {
                //  String imageUrl =
//                    await Provider.of<StorageService>(context, listen: false)
//                    .uploadMessageImage(imageFile);
//                _handleSubmitted(null, imageUrl);
                FirebaseAuth.instance.currentUser().then((user) async {
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child(user.uid)
                      .child('chat_img')
                      .child(Timestamp.now().toString() + '.jpg');
                  await ref.putFile(imageFile).onComplete;
                  final _url = await ref.getDownloadURL();
                  _handleSubmitted(null, _url);
                });
              }
            },
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
                ? () => _handleSubmitted(_textMessageController.text, null)
                : null,
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text, String imageurl) {
    //  FocusScope.of(context).unfocus();
 //   DateTime _currentdate = new DateTime.now();
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
        "toUserId": widget.tousername==null ? widget.post.data["userId"] : widget.touserId,
        "text": text,
        "imgurl": imageurl,
        "timestamp": Timestamp.now(),
      }); //  print(widget.post.data["profileImageURL"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
                backgroundImage: widget.tousername==null ? (widget.post.data["profileImageURL"]) == null ||widget.post.data["profileImageURL"]==""
                    ? AssetImage('assets/images/profile.jpeg')
                    : NetworkImage(widget.post.data["profileImageURL"]) : widget.toimgurl==null ||widget.toimgurl==""
                    ? AssetImage('assets/images/profile.jpeg')
                    : NetworkImage(widget.toimgurl)
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:widget.tousername==null ? widget.post.data["name"] != null
                      ? Text(widget.post.data["name"])
                      : Text("") : widget.toname != null
                      ? Text(widget.toname)
                      : Text(""),
                ),
                Text(widget.tousername==null ?
                  widget.post.data["username"] :widget.tousername,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            Spacer(),
            Icon(Icons.videocam),
            SizedBox(
              width: 10,
            ), IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>widget.tousername==null ? ChatDetails(
                      widget.post.data["name"],
                      widget.post.data["username"],
                    widget.post.data["profileImageURL"],
                    widget.post.data["userId"],) : ChatDetails(
                    widget.toname,
                    widget.tousername,
                    widget.toimgurl,
                    widget.touserId)),
                );
              },
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child:widget.tousername==null ? Messages(widget.post.data["userId"],
                  widget.post.data["profileImageURL"]) : Messages(widget.touserId,
                  widget.toimgurl),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
