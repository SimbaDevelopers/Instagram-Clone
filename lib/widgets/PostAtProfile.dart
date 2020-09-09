import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/widgets/CommentsListTile.dart';

class PostAtProfile extends StatefulWidget {
  @override
  _PostAtProfileState createState() => _PostAtProfileState();
}

class _PostAtProfileState extends State<PostAtProfile>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var postStream;
  String currentUserId;


  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((value) {
      currentUserId = value.uid;
      postStream = Firestore.instance
          .collection("posts")
          .where('userId' , isEqualTo: currentUserId)
          .orderBy("createdAt", descending: true)
          .snapshots();
    });
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    postStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            color: Colors.grey,
          ),
          Container(
            child: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.apps),
              ),
              Tab(
                icon: Icon(Icons.assignment_ind),
              ),
            ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              StreamBuilder(
                stream: postStream,
                builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) return Container();
                  return Container(
                    //height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:  GridView.count(
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: List.generate(
                          snapshot.data.documents.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CachedNetworkImage(
                                  imageUrl: snapshot.data.documents[index].data['postURL'],
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.black26,
                                          strokeWidth: 1,
                                          value: downloadProgress.progress),
                                    );
                                  })
//                              Container(
//                                child: Image.network(snapshot.data.documents[index].data['postURL']), //Text(snapshot.data[index].data["postURL"]),
//                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),

              Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("           Taged Posts......"),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
