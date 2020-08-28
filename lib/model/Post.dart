import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  String name;
  Timestamp timeStamp;
  String caption;
  String location;
  String postURL;
  String userId;
  String postId;
  String postType;
  int likesCount;
  int commentsCount;
  Map likesMap,saved;

  Post({
    this.caption,
    this.timeStamp,
    this.location,
    this.postURL,
    this.userId,
    this.postId,
    this.postType,
    this.likesCount,
    this.commentsCount,
    this.likesMap,
    this.saved,
});

  static Post fromMap(snapshot) {
    return Post(
      caption: snapshot['caption'],
      timeStamp: snapshot['createdAt'],
      location: snapshot['location'],
      postURL: snapshot['postURL'],
      userId: snapshot['userId'],
      postType: snapshot['postType'],
      likesCount: snapshot['likesCount'],
      commentsCount: snapshot['commentsCount'],
      likesMap: snapshot['likesMap'],
      saved: snapshot['saved'],
      postId: snapshot['postId'],
    );
  }
}