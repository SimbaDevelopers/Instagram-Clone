

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/model/Post.dart';

class PostList with ChangeNotifier{
  List<Post> _postList = [];
  var lastDocument;
  bool lastFetched = false;
  String currentUserId;
//  Map followingsMap;
  clearPostList () {
    _postList = [];
    lastDocument = null;
    lastFetched= false;
    notifyListeners();
  }

  List<Post> get postList  {
    return [..._postList];
  }

  Future<Null> getAndSetAllPost( int fetchLimit ) async {

    var _querySnapshot;

   await FirebaseAuth.instance.currentUser().then((currentUser) async {
      currentUserId = currentUser.uid;
      print(currentUserId);

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


     await Firestore.instance.collection('users').document(currentUserId).get().then((currenUserSnap) {

        for (DocumentSnapshot documentSnapshot in _querySnapshot.documents) {
          if(documentSnapshot.data['userId'] == currentUserId)
            {
              Post tekPost = Post.fromMap(documentSnapshot.data);
              _postList.add(tekPost);

            }else{
            switch(documentSnapshot.data['postType']){
              case 'public':
                Post tekPost = Post.fromMap(documentSnapshot.data);
                _postList.add(tekPost);
                break;
              case 'friends':
                if (currenUserSnap['followingsMap']
                    .containsKey(documentSnapshot.data['userId'])) {
                  Post tekPost = Post.fromMap(documentSnapshot.data);
                  _postList.add(tekPost);
                }
                break;
              case 'closeFriends':
                if (currenUserSnap['followingsMap']
                    .containsKey(documentSnapshot.data['userId'])) {
                  if (currenUserSnap['whoAddedUinCFsMap']
                      .containsKey(documentSnapshot.data['userId'])) {
                    Post tekPost = Post.fromMap(documentSnapshot.data);
                    _postList.add(tekPost);
                  }
                }
                break;
            }
          }
        }
      });
      notifyListeners();
    });
  }

  logout(){
     _postList = [];
     lastDocument = null;
     lastFetched = false;
  }
}