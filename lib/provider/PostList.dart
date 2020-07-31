

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/model/Post.dart';

class PostList with ChangeNotifier{
  List<Post> _postList = [];
  var lastDocument;
  bool lastFetched = false;
  String userId;
  Map followingsMap;
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
    if(userId == null ){
     FirebaseAuth.instance.currentUser().then((currentUser) async{
       userId = currentUser.uid;
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

       Firestore.instance.collection('users').document(userId).get().then((snapshot){
         followingsMap = snapshot['followingsMap'];

         for (DocumentSnapshot documentSnapshot in _querySnapshot.documents) {
           if(followingsMap.containsKey(documentSnapshot.data['userId'])) {
             Post tekPost = Post.fromMap(documentSnapshot.data);
             _postList.add(tekPost);
           }
         }
         notifyListeners();
       });
     });
    }else{
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

      Firestore.instance.collection('users').document(userId).get().then((snapshot){
        followingsMap = snapshot['followingsMap'];
      for (DocumentSnapshot documentSnapshot in _querySnapshot.documents) {
        if(followingsMap.containsKey(documentSnapshot.data['userId'])) {
          Post tekPost = Post.fromMap(documentSnapshot.data);
          _postList.add(tekPost);
        }
      }


      notifyListeners();
      });
    }

  //  return [..._postList];
  }

  logout(){
     _postList = [];
     lastDocument = null;
     lastFetched = false;
     userId = null;
   followingsMap = null;
  }
}