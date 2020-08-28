

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/helper/helpfunction.dart';
import 'package:instagram/model/Post.dart';
import 'package:instagram/provider/PostList.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:instagram/widgets/PostWidget.dart';
import 'package:provider/provider.dart';
import './SendPostBottomSheet.dart';

class PostHome extends StatefulWidget {

  @override
  _PostHomeState createState() => _PostHomeState();
}

class _PostHomeState extends State<PostHome> {

  String _userId;
  String _profileImage;
  String _userName;
  var data;
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
  }

  sendPost(String posturl){
    showModalBottomSheet(context: context,
        builder: (ctx) {
          return SendPostBottomSheet(posturl);
        });
  }


  @override
  void initState()   {

    getUserInfo();
    Future.delayed(Duration.zero).then((value) async {
   //   await Provider.of<UserInformation>(context ,listen: false).getUserInfo();
//     await Provider.of<PostList>(context ,listen: false).getAndSetAllPost(3).then((value) {
//       setState(() {});
//     });


    });
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
   final postData =  Provider.of<PostList>(context);
   final postList = postData.postList;
   final user= Provider.of<UserInformation>(context).user;


  // print(postList[0].userName);
    return postList == null || user == null  ?  LinearProgressIndicator(): ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: postList == null ? 0 : postList.length,
      itemBuilder: (context, index) {
        // print(postList[index].userName);
          return  PostWidget(postList[index] , sendPost);
//          return index == postList.length -1 ?  PostWidget(postList[index] , true , refreshPosts: refreshPosts,) : PostWidget(postList[index] , false);
      },
//      ),
    );

  }
}
