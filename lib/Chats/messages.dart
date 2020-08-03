import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Chats/image_bubble.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
Messages(this.onlyuser,this.userimg);
  final String onlyuser;
  final String userimg;
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx,futureSnapshot) {
//        if(futureSnapshot.connectionState==ConnectionState.waiting){
//         // print("gggggggggggggggggggggggg"+userimg);
//          return Center(child: Text(''),);
//        }
     return StreamBuilder(
      stream:     Firestore.instance
          .collection('chat_room')
          .orderBy(
          'timestamp',descending: true,)
          .snapshots(),
      builder: (ctx,chatSnapshot){

        if(chatSnapshot.connectionState==ConnectionState.waiting){

          return Center(child: CircularProgressIndicator(),
          );
        }
        final documents=chatSnapshot.data.documents;
        return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (ctx,index) {
              if(documents[index]['senderId']==onlyuser && documents[index]['toUserId']== futureSnapshot.data.uid){

                   if(documents[index]['text']!=null) {
                  return  MessageBubble(
                        documents[index]['text'],
                        documents[index]['senderId'] == futureSnapshot.data.uid,
                        userimg);
                  }else{
                    return ImageBubble(context, documents[index]['imgurl'],documents[index]['senderId'] == futureSnapshot.data.uid,userimg);
                  }

//              }else if(documents[index]['toUserId']==futureSnapshot.data.uid){
//
//              return MessageBubble(
//              documents[index]['text'],
//              documents[index]['senderId'] == futureSnapshot.data.uid,
//              );
//
              }
              else if(documents[index]['toUserId']==onlyuser && documents[index]['senderId']== futureSnapshot.data.uid){
               if(documents[index]['text']!=null) {
                 return MessageBubble(
                     documents[index]['text'],
                     documents[index]['senderId'] == futureSnapshot.data.uid,
                     userimg);
               }else{
                 return ImageBubble(context, documents[index]['imgurl'],documents[index]['senderId'] == futureSnapshot.data.uid,userimg);
               }
              }else{
                return Column();
              }

            });
      });
      },);
  }

}
