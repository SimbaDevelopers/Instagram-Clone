

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Pages/Search.dart';
import 'package:instagram/services/database.dart';

class SendPostBottomSheet extends StatefulWidget {
  SendPostBottomSheet(this.posturl);
  String posturl;
  @override
  _SendPostBottomSheetState createState() => _SendPostBottomSheetState();
}
String url;

class _SendPostBottomSheetState extends State<SendPostBottomSheet> {

  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController searchtextEditingcontroller =
  new TextEditingController();
  bool isSearching = false;
  QuerySnapshot searchSnapshot;
  initiateSearch() {

    isSearching = true;
    databaseMethod
        .getUserByUsername(searchtextEditingcontroller.text)
        .then((val) {
      setState(() {
        isSearching = false;
        searchSnapshot = val;
        print(searchtextEditingcontroller);
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {

          return Searchtile(
            docSnap: searchSnapshot.documents[index],
          );
        })
        : Center(
        child: Container(
          child: Text('Result Not Found'),
        ));
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: SingleChildScrollView(

        child: Column(

          children: <Widget>[
            Container(padding: EdgeInsets.symmetric(vertical: 1),
              decoration: BoxDecoration(color: Colors.white10,borderRadius:BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (val) {
                     url=widget.posturl;
                    initiateSearch();
                  },
                  controller: searchtextEditingcontroller,
                  decoration: InputDecoration(
                      labelText: 'Search....',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
               child: searchList(),
            )
          ],
        ),
      ),
    );
  }
}
class Searchtile extends StatelessWidget {

  final docSnap;

  Searchtile({
    this.docSnap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

//        Navigator.of(context).pushNamed(ProfilePage.routeName , arguments: {
////        'username' : docSnap.data['username'],
//          'userId' : docSnap.data['userId'],
//
//        });

      } ,
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:docSnap.data['profileImageURL']==null ?AssetImage(
                      'assets/images/profile.jpeg',) : NetworkImage(docSnap.data['profileImageURL']),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          docSnap.data['username'],
                        ),
                      ),
                      Text(
                        docSnap.data['name'],
                      )
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.blue[400])),
                      color: Colors.blue[400],
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(3),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        _handleSubmitted(docSnap.data['userId'],url);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        ' Send ',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

void _handleSubmitted(String userid, String imageurl) {

  FirebaseAuth.instance.currentUser().then((user) {
    Firestore.instance.collection('chat_room').add({
      "senderId": user.uid,
      "toUserId": userid,
      "text": null,
      "imgurl": imageurl,
      "timestamp": Timestamp.now(),
    });
  });
}