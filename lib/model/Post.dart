import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  String userName;
  String name;
  Timestamp timeStamp;
  String caption;
  String location;
  String postURL;
  String userId;
  String profileImageURL;


  Post({
    this.caption,
    this.timeStamp,
    this.location,
    this.postURL,
    this.userId,
//    this.userName,
//    this.profileImageURL,
});

   static Post fromMap(snapshot){
    return Post(
      caption: snapshot['caption'],
      timeStamp: snapshot['createdAt'],
      location : snapshot['location'],
      postURL:  snapshot['postURL'],
      userId: snapshot['userId'],
//      userName: snapshot['username'],
//      profileImageURL: snapshot['profileImageURL'].toString(),

    );
  }
}