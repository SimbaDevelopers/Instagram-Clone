import 'package:flutter/material.dart';
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
  sendPost(String posturl){
    showModalBottomSheet(context: context,
        builder: (ctx) {
          return SendPostBottomSheet(posturl);
        });
  }
  @override
  Widget build(BuildContext context) {
   final postData =  Provider.of<PostList>(context);
   final postList = postData.postList;
   final user= Provider.of<UserInformation>(context).user;
    return postList == null || user == null  ?  LinearProgressIndicator(): ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: postList == null ? 0 : postList.length,
      itemBuilder: (context, index) {
          return  PostWidget(postList[index] , sendPost);
      },
    );

  }
}
