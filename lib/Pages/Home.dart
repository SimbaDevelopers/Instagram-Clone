import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Chats/all_users.dart';
import 'package:instagram/Screens/AddStory.dart';
import 'package:instagram/model/chatuser.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/PostList.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:instagram/widgets/PostHomeScreen.dart';
import 'package:instagram/widgets/storybar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'bottom_nav.dart';
import 'package:instagram/services/auth.dart';
class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<HomePage> {
  AuthMethod authMethod = new AuthMethod();
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<UserInformation>(context ,listen: false).getUserInfo().then((value)  async{
        await Provider.of<PostList>(context ,listen: false).getAndSetAllPost(5);
      });

    });
    super.initState();
  }






//  refreshPage() async {
//    Provider.of<PostList>(context , listen: false).clearPostList();
//    Provider.of<PostList>(context , listen: false).getAndSetAllPost(2);
//
//    return 'sdfsf';
//  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  void _onRefresh() async {
    Provider.of<PostList>(context, listen: false).clearPostList();

    Provider.of<PostList>(context, listen: false).getAndSetAllPost(5);
    _refreshController.refreshCompleted();
    setState(() {
    });

  }

  void _onLoading() async{
    await Provider.of<PostList>(context , listen: false).getAndSetAllPost(5);
    _refreshController.loadComplete();
  }
//  FRefreshController controller = FRefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                //  getImage(false);
                  Navigator.of(context).pushNamed( AddStory.routeName);
                },
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Instagram',
                style: TextStyle(fontSize: 25.0, fontFamily: 'Billabong'),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => All_Users()),
                  );
                },
                child: Icon(Icons.send),
              ),
            )
          ],
        ),

        body:
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),

          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                body =  Text("pull up to load");
              }
              else if(mode==LoadStatus.loading){
                body =  CupertinoActivityIndicator();
              }
              else if(mode == LoadStatus.failed){
                body = Text("Load Failed!Click retry!");
              }
              else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
              }
              else{
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child:body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
              //  isUploading ? LinearProgressIndicator() : SizedBox(),
                StoryBar(),
                Divider(
                  color: Colors.white,
                ),
                PostHome(),
//                Divider(
//                  height: 20,
//                  color: Colors.white,
//                ),
              ],
            ),
          ),
        ),


        bottomNavigationBar: BottomNavigation('HomePage' , context),
    );
  }
}
