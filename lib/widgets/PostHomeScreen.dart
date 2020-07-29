

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/helper/helpfunction.dart';
import 'package:instagram/model/Post.dart';
import 'package:instagram/provider/PostList.dart';
import 'package:instagram/widgets/PostWidget.dart';
import 'package:provider/provider.dart';

class PostHome extends StatefulWidget {
  @override
  _PostHomeState createState() => _PostHomeState();
}

class _PostHomeState extends State<PostHome> {

  String _userId;
  String _profileImage;
  String _userName;
  var data;
//  List<Post> postList = [];
// var postList;


  Future getUserInfo() async {
    HelperFunction.getuserIdSharedPreferecne().then((uid){
      _userId = uid;
      HelperFunction.getProfileImageUrlSharedPreference().then((image){
        _profileImage = image;
        HelperFunction.getusernameSharedPreferecne().then((username) {
          _userName = username;
        });
      });
    });
//     data = await Firestore.instance.collection('posts').orderBy('createdAt' , descending: true ).getDocuments();
//     setState(() {
//       postList = data.documents;
//     });
  }
  refreshPosts() async {
    await Provider.of<PostList>(context , listen: false).getAndSetAllPost(2);
  }
  @override
  void initState()   {

    getUserInfo();
    Future.delayed(Duration.zero).then((value) async {
     await Provider.of<PostList>(context ,listen: false).getAndSetAllPost(2);

    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   final postData =  Provider.of<PostList>(context);
   final postList = postData.postList;

  // print(postList[0].userName);
    return RefreshIndicator(
      child: postList == null ?  Center(child: CircularProgressIndicator()) : ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: postList == null ? 0 : postList.length,
        itemBuilder: (context, index) {
          // print(postList[index].userName);
          return index == postList.length -1 ?  PostWidget(postList[index] , true , refreshPosts: refreshPosts,) : PostWidget(postList[index] , false);
        },
//      ),
      ),
      onRefresh: (){},
    );

  }
}
