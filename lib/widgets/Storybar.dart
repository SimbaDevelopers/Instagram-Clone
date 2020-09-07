import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screens/StoryScreen.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/helper/helpfunction.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';

class StoryBar extends StatefulWidget {
  @override
  _StoryBarState createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {
  UserModel currentUser;

  List<String> followingsUserId = [];
  var currentUsersStory;
  bool currentUsersStoryExist;

  storyExist() async {
    currentUsersStory = await Firestore.instance
        .collection('stories')
        .document(currentUser.userId)
        .get();
    currentUsersStoryExist = currentUsersStory.exists;
    return currentUsersStoryExist;
  }

  refrashStoryBar() {
    setState(() {});
  }

  getStories() async {
    followingsUserId.clear();
    currentUser.followingsMap.forEach((k, v) {
      if (k != currentUser.userId) followingsUserId.add(k);
    });

    return await Firestore.instance
        .collection('stories')
        .where("timeStamp",
            isGreaterThanOrEqualTo:
                new DateTime.now().subtract(new Duration(days: 1)))
        .orderBy('timeStamp', descending: true)
        .getDocuments();

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInformation>(
      builder: (context, userInfo, child) {
        if (userInfo.user == null) return SizedBox();
        currentUser = userInfo.user;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await storyExist();
                if (currentUsersStoryExist) {
                  List<Map> stories = [];
                  stories.add(currentUsersStory.data);
                  Navigator.of(context)
                      .pushNamed(StoryScreen.routeName, arguments: {
                    'storyMap': stories[0],
                    'storyIndex': 0,
                    'stories': stories,
                    'maxIndex': stories.length
                  });
                }
              },
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image(
                        image: NetworkImage(currentUser.profileImageURL),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(currentUser.username),
                ],
              ),
            ),
            Flexible(
                child: Column(
              children: <Widget>[
                SizedBox(
                  // Horizontal ListView
                  height: 100,
                  child: FutureBuilder(
                    future: getStories(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      List<Map> stories = [];
                      List<Map> seenStories = [];
                      List<Map> unseenStories = [];
                      stories.clear();
                      for (DocumentSnapshot documentSnapshot
                          in snapshot.data.documents) {
                        if (currentUser.followingsMap
                                .containsKey(documentSnapshot.data["userId"]) &&
                            currentUser.userId !=
                                documentSnapshot.data["userId"]) {
                          if (documentSnapshot.data['seenBy']
                              .containsKey(currentUser.userId))
                            seenStories.add(documentSnapshot.data);
                          else
                            unseenStories.add(documentSnapshot.data);
                        }
                      }

                      stories = unseenStories + seenStories;
                      return ListView.builder(
                        itemCount: stories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(StoryScreen.routeName, arguments: {
                                'storyMap': stories[index],
                                'storyIndex': index,
                                'stories': stories,
                                'maxIndex': stories.length,
                                'refrashStoryBar': refrashStoryBar
                              });
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        width: 2,
                                        color: stories[index]["seenBy"]
                                                .containsKey(currentUser.userId)
                                            ? Colors.grey
                                            : Colors.blue),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image(
                                      image: NetworkImage(
                                          stories[index]['profileImageURL']),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(stories[index]['username']),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )),
          ],
        );
      },
    );
  }

  _backFromStoriesAlert() {
    showDialog(
      context: context,
      child: SimpleDialog(
        title: Text(
          "User have looked stories and closed them.",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: Text("Dismiss"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
