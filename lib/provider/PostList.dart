

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/model/Post.dart';

class PostList with ChangeNotifier{
  List<Post> _postList = [];
  var lastDocument;
  bool lastFetched = false;

  clearPostList () {
    _postList = [];
    lastDocument = null;
    lastFetched= false;
    notifyListeners();
  }

  List<Post> get postList  {

    return [..._postList];
  }

  Future<Null> getAndSetAllPost( int fetchLimit) async {

    var _querySnapshot;

    if (!lastFetched) {
      _querySnapshot = await Firestore.instance
          .collection("posts")
          .orderBy("createdAt", descending: true)
          .limit(fetchLimit)
          .getDocuments();
      lastFetched = true;
    } else {
      _querySnapshot = await Firestore.instance
          .collection("posts")
          .orderBy("createdAt", descending: true)
          .startAfterDocument(lastDocument)
          .limit(fetchLimit)
          .getDocuments();
      print('in post list elase part');
    }
    if (_querySnapshot.documents.length != 0) {
      lastDocument =
      _querySnapshot.documents[_querySnapshot.documents.length - 1];
    }

    for (DocumentSnapshot documentSnapshot in _querySnapshot.documents) {
      Post tekPost = Post.fromMap(documentSnapshot.data);
      _postList.add(tekPost);
    }


    notifyListeners();

  //  return [..._postList];
  }
}