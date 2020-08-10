import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import '../widgets/LikeTile.dart';

class LikesScreen extends StatefulWidget {
  static const routeName = '/LikesScreen';
  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  var arguments ;
  UserModel currentUser;
  String postId;
  List<String> likersList = [];
  var stream;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments as Map;
    postId = arguments['postId'];
    currentUser = arguments['user'];
    stream = Firestore.instance.collection('posts').document(postId).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Likes'),
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) return Center( child: CircularProgressIndicator(),);
          snapshot.data['likesMap'].keys.forEach((k) {
            likersList.add(k);
          });
          return ListView.builder(
              itemCount: snapshot.data['likesMap'].length,
              itemBuilder: (ctx, index) {
                return LikesTile(likerId: likersList[index], user: currentUser,);
              });
        },
      ),
    );

  }
  @override
  void dispose() {
    stream =null;
    // TODO: implement dispose
    super.dispose();
  }

}
