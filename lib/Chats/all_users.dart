import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/helper/constants.dart';

import 'chat_room.dart';


class All_Users extends StatefulWidget {
  @override
  _All_UsersState createState() => _All_UsersState();
}

class _All_UsersState extends State<All_Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Chats")),
    body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;
  Future getPosts() async{
    var firestore =Firestore.instance;
   QuerySnapshot qn= await firestore.collection("users").getDocuments();
   return qn.documents;
  }
  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>DetailPage(post: post,)));
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
          
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: Text("Loading..."),
          );
        }else{
      return ListView.builder(
        itemCount: snapshot.data.length,
          itemBuilder: (_,index){
            Constants.chatname=snapshot.data[index].data["username"];
          return ListTile(
            title: Text(snapshot.data[index].data["username"]),
            onTap: ()=> navigateToDetail(snapshot.data[index]),
          );
      });
        }
      }),
    );
  }
}





