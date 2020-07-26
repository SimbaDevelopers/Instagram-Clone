import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Pages/Home.dart';
import 'package:instagram/services/database.dart';

import 'Activity.dart';
import 'Add.dart';
import 'Profile.dart';
import 'bottom_nav.dart';

void main() => runApp(SearchPage());

class SearchPage extends StatefulWidget {
  static const routeName = '/SearchPage';
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching = false;
  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController searchtextEditingcontroller =
      new TextEditingController();

  QuerySnapshot searchSnapshot;
  initiateSearch() {
    isSearching = true;
    databaseMethod
        .getUserByUsername(searchtextEditingcontroller.text)
        .then((val) {
      setState(() {
        isSearching = false;
        searchSnapshot = val;
      });
      ;
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Searchtile(
                userEmail: searchSnapshot.documents[index].data["username"],
                userName: searchSnapshot.documents[index].data["email"],
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
    return Scaffold(

        appBar: AppBar(
          title: Row(
            children: <Widget>[
//              Icon(
//                Icons.keyboard_arrow_left,
//                size: 50,
//              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    onChanged: (val) {
                      initiateSearch();
                    },
                    controller: searchtextEditingcontroller,
                    decoration: InputDecoration(
                        hintText: "search", border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Icon(Icons.search),
                ),
              )
            ],
          ),
        ),
        body: isSearching
            ? Center(child: CircularProgressIndicator())
            : searchList(),
      bottomNavigationBar: BottomNavigation('SearchPage' , context),
    //  bottomNavigationBar: BottomNavigation('SearchPage', context),
//      bottomNavigationBar: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//
//            GestureDetector(
//              onTap: (){
//
//                bool isNewRouteSameAsCurrent = false;
//
////                Navigator.of(context).popUntil( (route) {
////                  if (route.settings.name == HomePage.routeName) {
////                    isNewRouteSameAsCurrent = true;
////                  }
////                  return false;
////                });
//
//                if (!isNewRouteSameAsCurrent) {
//                  Navigator.of(context).pushNamed(HomePage.routeName);
//                }
//
//              },
//              child: Icon(Icons.home , size: 35, color: Colors.grey,),
//            ),
//            GestureDetector(
//
//              child: Icon(Icons.search, size: 35, color: Colors.white,),
//            ),
//            GestureDetector(
//              onTap: (){
//                Navigator.of(context).pushNamed(AddPage.routeName);
//              },
//              child: Icon(Icons.add, size: 35,color: Colors.grey,),
//            ),
//            GestureDetector(
//              onTap: (){
//                Navigator.of(context).pushNamed(ActivityPage.routeName);
//              },
//              child: Icon(Icons.favorite_border, size: 35,color: Colors.grey,),
//            ),
//            GestureDetector(
//              onTap: (){
//                Navigator.of(context).pushNamed(ProfilePage.routeName);
//              },
//              child: Icon(Icons.supervised_user_circle, size: 35,color: Colors.grey,),
//            ),
//
//          ],
//        ),
//      ),

        //  Container(
        //   child: Column(children: [
        //     Container(
        //       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        //       child: Row(children: [
        //         Expanded(
        //             child: TextField(
        //           controller: searchtextEditingcontroller,
        //           decoration: InputDecoration(
        //               hintText: "search", border: InputBorder.none),
        //         )),
        //         GestureDetector(
        //           onTap: () {
        //             initiateSearch();
        //           },
        //           child: Container(
        //               padding: EdgeInsets.all(10),
        //               child: Image.asset("assets/images/search.png")),
        //         ),
        //       ]),
        //     ),
        //     searchList()
        //   ]),
        // ),


        );
  }
}

class Searchtile extends StatelessWidget {
  final String userName;
  final String userEmail;
  Searchtile({this.userName, this.userEmail});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/profile.jpeg',
                ),
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
                      userName,
                    ),
                  ),
                  Text(
                    userEmail,
                  )
                ],
              ),
              Spacer(),
              Text("X"),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
