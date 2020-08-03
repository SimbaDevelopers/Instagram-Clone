import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Chats/all_users.dart';
import 'package:instagram/provider/PostList.dart';
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
      await Provider.of<PostList>(context ,listen: false).getAndSetAllPost(5);
    });
    super.initState();
  }


  File _image;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

//  refreshPage() async {
//    Provider.of<PostList>(context , listen: false).clearPostList();
//    Provider.of<PostList>(context , listen: false).getAndSetAllPost(2);
//
//    return 'sdfsf';
//  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  void _onRefresh() async{
    Provider.of<PostList>(context , listen: false).clearPostList();

    Provider.of<PostList>(context , listen: false).getAndSetAllPost(5);
    _refreshController.refreshCompleted();
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
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  getImage(true);
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
                StoryBar(),
                Divider(
                  color: Colors.white,
                ),
                PostHome(),
                Divider(
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),


        bottomNavigationBar: BottomNavigation('HomePage' , context),
//        bottomNavigationBar: BottomNavigation('HomePage' , context),
//        bottomNavigationBar: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//
//              GestureDetector(
//
//                  child: Icon(Icons.home , size: 35, color: Colors.white,),
//              ),
//              GestureDetector(
//                onTap: (){
//                    Navigator.of(context).pushNamed(SearchPage.routeName);
//                },
//                child: Icon(Icons.search, size: 35, color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(AddPage.routeName);
//                },
//                child: Icon(Icons.add, size: 35,color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(ActivityPage.routeName);
//
//                },
//                child: Icon(Icons.favorite_border, size: 35,color: Colors.grey,),
//              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.of(context).pushNamed(ProfilePage.routeName);
//                },
//                child: Icon(Icons.supervised_user_circle, size: 35,color: Colors.grey,),
//              ),
//
//            ],
//          ),
//        ),
   //   ),
    );
  }
}



// ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: 60,
//                   itemBuilder: (context, index) {
//                     return Text('Some text');
//                   })



//this is for testing.....