import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Chats/chat_details.dart';
import 'package:instagram/Chats/messages.dart';
import 'package:instagram/helper/app_constants.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/main.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/services/database.dart';
import 'package:instagram/src/pages/call.dart';
import 'package:instagram/src/pages/index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'constant_chat.dart';
import 'database_chat.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  final toimgurl, toname, tousername, touserId;

  DetailPage(
      this.post, this.toname, this.tousername, this.toimgurl, this.touserId);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ClientRole _role = ClientRole.Broadcaster;
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

          Expanded(
            child: Column(
              children: [
                TextField(
                  controller: _textMessageController,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;

                      if (text.length > 0) {
                        Map<String, Object> userInfoMap = {
                          "istyping": widget.tousername == null
                              ? widget.post.data["userId"]
                              : widget.touserId,
                        };
                        dataBaseService.isTyping(userInfoMap);
                      } else {
                        Map<String, Object> userInfoMap = {
                          "istyping": "",
                        };
                        dataBaseService.isTyping(userInfoMap);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 0),
                      child: RawMaterialButton(
                        onPressed: () async {
                            File image;
                              image = await ImagePicker.pickImage(source: ImageSource.camera);
//                            setState(() {
//                              _image = image;
//                            });

                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: Colors.blue,
                        padding: EdgeInsets.all(5.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),),
                        borderSide: BorderSide(color: Colors.white10)
                    ),focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),),
                      borderSide: BorderSide(color: Colors.white10)
                  ),
                    hintText: 'Message...',
                    filled: true,fillColor: Colors.black,
                    hintStyle: TextStyle(color: Colors.white),
                    suffixIcon: _isComposing ? InkWell(
                      onTap: _isComposing
                          ? () => _handleSubmitted(_textMessageController.text, null)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                        child: Expanded(child: Text(
                          'Send',
                          style: TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold),
                        ),),
                      ),
                    ) : Container(
                      padding:  const EdgeInsets.only(left: 200),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.mic,color: Colors.white,), onPressed: () {  },
                            ),
                            IconButton(
                              icon: Icon(Icons.image,color: Colors.white), onPressed: () async {
                              File imageFile = await ImagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (imageFile != null) {

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
                            ),
                            IconButton(
                              icon: Icon(Icons.gif,color: Colors.white), onPressed: () {  },
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
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
      Firestore.instance.collection('chat_room').add({
        "senderId": user.uid,
        "toUserId": widget.tousername == null
            ? widget.post.data["userId"]
            : widget.touserId,
        "text": text,
        "imgurl": imageurl,
        "tovideocall": null,
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
                backgroundImage: widget.tousername == null
                    ? (widget.post.data["profileImageURL"]) == null ||
                            widget.post.data["profileImageURL"] == ""
                        ? AssetImage('assets/images/profile.jpeg')
                        : NetworkImage(widget.post.data["profileImageURL"])
                    : widget.toimgurl == null || widget.toimgurl == ""
                        ? AssetImage('assets/images/profile.jpeg')
                        : NetworkImage(widget.toimgurl)),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: widget.tousername == null
                      ? widget.post.data["name"] != null
                          ? Text(widget.post.data["name"])
                          : Text("")
                      : widget.toname != null ? Text(widget.toname) : Text(""),
                ),
                Text(
                  widget.tousername == null
                      ? widget.post.data["username"]
                      : widget.tousername,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.video_call),
                onPressed: ()=> onJoin()
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => widget.tousername == null
                          ? ChatDetails(
                              widget.post.data["name"],
                              widget.post.data["username"],
                              widget.post.data["profileImageURL"],
                              widget.post.data["userId"],
                            )
                          : ChatDetails(widget.toname, widget.tousername,
                              widget.toimgurl, widget.touserId)),
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
              child: widget.tousername == null
                  ? Messages(widget.post.data["userId"],
                      widget.post.data["profileImageURL"],widget.post.data["username"])
                  : Messages(widget.touserId, widget.toimgurl,widget.toname),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
   await FirebaseAuth.instance.currentUser().then((value) {
      Constants.uid=value.uid;
      final dbRef = FirebaseDatabase.instance.reference().child("users");

     dbRef.child(Constants.uid).once().then((data) async {
     //  print(data.value["Onvideocall"]);
//       setState(() {
//         print("llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll");
//         // retrievedName = data.value;
//       });
     //});


    if (data.value["Onvideocall"]=="0" || data.value["Onvideocall"]==null) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();

      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance.collection('chat_room').add({
          "senderId": user.uid,
          "toUserId": widget.tousername == null
              ? widget.post.data["userId"]
              : widget.touserId,
          "tovideocall": true,
          "timestamp": Timestamp.now(),
        }); //  print(widget.post.data["profileImageURL"]);
      });

      final dbRef1 = FirebaseDatabase.instance.reference().child("users");
      dbRef1.child(widget.post.data["userId"]).set({
        "Onvideocall": Constants.uid,
      });
//      final dbRef2 = FirebaseDatabase.instance.reference().child("users");
//      dbRef2.child(Constants.uid).set({
//        "Onvideocall": widget.post.data["userId"],
//      });
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: Constants.uid,
            role: _role,
            touserId: widget.post.data["userId"],
          ),
        ),
      );
    }else{
      await _handleCameraAndMic();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: data.value["Onvideocall"],
            role: _role,
            touserId: null,
          ),
        ),
      );
    }

  });});
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
