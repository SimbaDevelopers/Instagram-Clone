import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  Future _data;
  String userid;
  @override
  void initState() {
    super.initState();
    _data=getPosts();
  }
  Future getPosts() async{
    QuerySnapshot qn;
    var firestore =Firestore.instance;
    await FirebaseAuth.instance.currentUser().then((user) async {
     qn= await firestore.collection("users").document(user.uid).collection("saved").getDocuments();
    });
    return qn.documents;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved"),),
      body: Container(
        child: FutureBuilder(
            future: _data,
            builder: (_, snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: Text(""),
                );
              }else{
                return GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(snapshot.data.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          child:Image.network(snapshot.data[index].data["imgurl"]),
                        ),
                      );
                    }));
              }

              //  });
            }
        ),
      ),
    );
  }
}
