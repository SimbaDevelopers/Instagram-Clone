import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/services/database.dart';

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
              Icon(
                Icons.keyboard_arrow_left,
                size: 50,
              ),
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
            : searchList()
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
