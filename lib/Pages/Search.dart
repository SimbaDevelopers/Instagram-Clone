import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/services/database.dart';
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
  Future _data;
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
    });
  }

  @override
  void initState() {
    super.initState();
    _data = getPosts();
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("posts").getDocuments();
    return qn.documents;
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Searchtile(
                docSnap: searchSnapshot.documents[index],
              );
            })
        : Container(
            child: FutureBuilder(
              future: _data,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(""),
                  );
                } else {
                  return GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                      snapshot.data.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            child: Image.network(snapshot.data[index].data[
                                "postURL"]), //Text(snapshot.data[index].data["postURL"]),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
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
      bottomNavigationBar: BottomNavigation('SearchPage', context),
    );
  }
}

class Searchtile extends StatelessWidget {
  final docSnap;

  Searchtile({
    this.docSnap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).pushNamed(ProfilePage.routeName, arguments: {
          'userId': docSnap.data['userId'],
        });
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: docSnap.data['profileImageURL'] == null
                      ? AssetImage(
                          'assets/images/profile.jpeg',
                        )
                      : NetworkImage(docSnap.data['profileImageURL']),
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
                        docSnap.data['username'],
                      ),
                    ),
                    Text(
                      docSnap.data['name'] != null ? docSnap.data['name'] : "",
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
      ),
    );
  }
}
