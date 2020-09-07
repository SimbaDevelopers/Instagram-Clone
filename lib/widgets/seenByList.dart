import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class seenByBottomSheet extends StatefulWidget {
  final String userId;
  final String storyId;

  seenByBottomSheet({this.userId, this.storyId});

  @override
  _seenByBottomSheetState createState() => _seenByBottomSheetState();
}


class _seenByBottomSheetState extends State<seenByBottomSheet> {

  String stream;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,

      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Seen By" , style: TextStyle(fontSize: 20),),
                    Divider()
                  ],
                ),
              ),
            ),
            Container(
              height: 300,
              child: FutureBuilder(
                future: Firestore.instance.collection('stories').document(
                    widget.userId).collection('userStories')
                    .document(widget.storyId)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return ListTile();
                  List<String> users =[];
                  snapshot.data['seenBy'].forEach((k, v) => users.add(k));
                  return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context , index) {
                        return FutureBuilder(
                            future: Firestore.instance.collection('users').document(
                                users[index]).get(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return ListTile();
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data['profileImageURL']),
                                ),
                                title: Text(snapshot.data['username']),
                                subtitle: Text(snapshot.data['name']),
                              );
                            });
                      });

//              FutureBuilder(
//                future: Firestore.instance.collection('users').document(
//                    snapshot.data[]).get(),
//                builder: (context, snapshot) {
//                  if (!snapshot.hasData) return ListTile();
//                  return SizedBox();
//                }

                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
