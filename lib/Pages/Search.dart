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
  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController searchtextEditingcontroller =
      new TextEditingController();

  QuerySnapshot searchSnapshot;
  initiateSearch() {
    databaseMethod
        .getUserByUsername(searchtextEditingcontroller.text)
        .then((val) {
      setState(() {
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
        : Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: searchtextEditingcontroller,
                  decoration: InputDecoration(
                      hintText: "search", border: InputBorder.none),
                )),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset("assets/images/search.png")),
                ),
              ]),
            ),
            searchList()
          ]),
        ),
      ),
    );
  }
}

class Searchtile extends StatelessWidget {
  final String userName;
  final String userEmail;
  Searchtile({this.userName, this.userEmail});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
              ),
              Text(
                userEmail,
              )
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("In"),
          )
        ],
      ),
    );
  }
}
