import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/helper/helpfunction.dart';

import 'chat_room.dart';




class All_Users extends StatefulWidget {
  @override
  _All_UsersState createState() => _All_UsersState();
}

class _All_UsersState extends State<All_Users> {
  String username;
  @override
  Widget build(BuildContext context) {
    HelperFunction.getusernameSharedPreferecne().then((value) {
      setState(() {
        username=value;
       // print(username);
      });
    });
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(title: Text(username!=null ? username : "")),
       body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String uid;
  Future _data;
  Future getPosts() async{
    var firestore =Firestore.instance;
   QuerySnapshot qn= await firestore.collection("users").getDocuments();
   return qn.documents;
  }
  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>DetailPage(post,null,null,null,null)));
  }
  @override
  void initState() {
    super.initState();
_data=getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _data,
          builder: (_, snapshot){
            getuid();
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: Text(""),
          );
        }else{
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (_,index){
            Constants.chatname=snapshot.data[index].data["username"];
            if(snapshot.data[index].data["userId"]!=uid){
             // print(snapshot.data[index].data["userId"]+"aaaaa"+uid);
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10
                ),
                leading: Container(
                  padding: EdgeInsets.symmetric(
                        horizontal: 10
                  ),
                  child: CircleAvatar(
                    backgroundImage:snapshot.data[index].data["profileImageURL"]==null ||snapshot.data[index].data["profileImageURL"]=="" ?
                    AssetImage('assets/images/profile.jpeg') : NetworkImage(snapshot.data[index].data["profileImageURL"]),
                  ),
                ),
                title: Text(snapshot.data[index].data["username"]==null ? "" :snapshot.data[index].data["username"]),
                onTap: ()=> navigateToDetail(snapshot.data[index]),
              );
            }else{
              return Column();
            }

      });
        }
      }),
    );
  }

  getuid() {
    FirebaseAuth.instance.currentUser().then((value){
      uid=value.uid;
        });
  }
}





