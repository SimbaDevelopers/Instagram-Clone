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
  var likesCount;

  getLikersList( postId , currentUser) async {
    await Firestore.instance.collection('posts').document(postId).get().then((value) {
      likesCount = value['likesCount'];
      var likesMap = value['likesMap'];
      likesMap.keys.forEach((k) {
        likersList.add(k);
      });
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments as Map;
    postId = arguments['postId'];
    currentUser = arguments['user'];
    if(likersList.isEmpty )
        getLikersList(postId , currentUser);
    return Scaffold(
      appBar: AppBar(
        title: Text('Likes'),
      ),
      body: likersList.isEmpty || arguments == null || currentUser == null ? Center(child : CircularProgressIndicator())
          : ListView.builder( itemCount : likersList == null ? 0 : likersList.length ,
          itemBuilder: (ctx , index){
            print(likersList);
            return LikesTile(likerId: likersList[index], user: currentUser,) ;
          } ) ,
    );
  }
}
