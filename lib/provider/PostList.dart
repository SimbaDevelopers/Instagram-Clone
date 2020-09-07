import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/model/Post.dart';

class PostList with ChangeNotifier {
  List<Post> _postList = [];
  var lastDocument;
  bool lastFetched = false;
  String currentUserId;

//  Map followingsMap;
  clearPostList() {
    _postList = [];
    lastDocument = null;
    lastFetched = false;
    notifyListeners();
  }

  List<Post> get postList {
    return [..._postList];
  }

  Future<Null> getAndSetAllPost(int fetchLimit) async {
    var _querySnapshot;

    await FirebaseAuth.instance.currentUser().then((currentUser) async {
      currentUserId = currentUser.uid;
//      print(currentUserId);

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

      await Firestore.instance
          .collection('users')
          .document(currentUserId)
          .get()
          .then((currenUserSnap) {
        for (DocumentSnapshot documentSnapshot in _querySnapshot.documents) {
          if (documentSnapshot.data['userId'] == currentUserId) {
            Post tekPost = Post.fromMap(documentSnapshot.data);
            _postList.add(tekPost);
          } else {
            switch (documentSnapshot.data['postType']) {
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
saved(String postId,String currentuserid,String posturl)async{
  Firestore.instance
      .collection('users')
      .document(currentuserid)
      .collection("saved").document(postId)
      .setData({
    "postId" : postId,
    "imgurl": posturl,
  });

}
unsave(String postId,String currentuserid,String posturl)async{
  Firestore.instance.collection('users').document(currentuserid).collection("saved").document(postId).updateData({
    'imgurl': "",
    'postId':"",
  });
}
  likePost(String postId, int likesCount, String likerId) async {
    Firestore.instance
        .collection('posts')
        .document(postId)
        .updateData({'likesMap.${likerId}': true});
    final post = _postList.firstWhere((post) => post.postId == postId);
    post.likesCount++;
    Firestore.instance.collection('posts').document(postId).updateData({
      'likesCount': post.likesCount,
    });
    post.likesMap[likerId] = true;

    //======== Activity Feed =======
//    if(post.userId != currentUserId) {
    Firestore.instance
        .collection('feeds')
        .document(post.userId)
        .collection('feedItems')
        .add({
      'type': 'like',
      'userId': likerId,
      'postId': postId,
      'timeStamp': DateTime.now(),
    });
//    }
    notifyListeners();
  }

  unlikePost(String postId, int likesCount, String likerId, {posterId}) async {
    if(likesCount > 0) {
      Firestore.instance.collection('posts').document(postId).updateData({
        'likesMap.${likerId}': FieldValue.delete(),
      });
      final post = _postList.firstWhere((post) => post.postId == postId);
      post.likesCount--;
      Firestore.instance.collection('posts').document(postId).updateData({
        'likesCount': post.likesCount,
      });
      post.likesMap.remove(likerId);

      //===============Activity Feed =====================
//     if(post.userId != currentUserId) {
      var _querySnapshot = await Firestore.instance
          .collection('feeds')
          .document(posterId)
          .collection('feedItems')
          .where('postId', isEqualTo: postId)
          .where('type', isEqualTo: 'like')
          .where('userId', isEqualTo: likerId)
          .getDocuments();
      if (_querySnapshot.documents.length > 0) {
        Firestore.instance
            .collection('feeds')
            .document(posterId)
            .collection('feedItems')
            .document(_querySnapshot.documents[0].documentID)
            .delete();
//      }
      }
      notifyListeners();
    }
  }

  addComment(postId, userId, comment) async {
    if (currentUserId == null) {
      return;
    } else {
      final snap = await Firestore.instance
          .collection('posts')
          .document(postId)
          .collection('comments')
          .add({
        'comment': comment,
        'userId': userId,
        'timeStamp': DateTime.now()
      });

      Firestore.instance
          .collection('posts')
          .document(postId)
          .collection('comments')
          .document(snap.documentID)
          .updateData({'commentId': snap.documentID});
      final post = _postList.firstWhere((post) => post.postId == postId);

      post.commentsCount++;
      await Firestore.instance.collection('posts').document(postId).updateData({
        'commentsCount': post.commentsCount,
      }).then((value) {
        //======== Activity Feed =======
            if(post.userId != currentUserId) {
        Firestore.instance
            .collection('feeds')
            .document(post.userId)
            .collection('feedItems')
            .add({
          'type': 'comment',
          'comment': comment,
          'userId': currentUserId,
          'postId': postId,
          'commentId': snap.documentID,
          'timeStamp': DateTime.now(),
        });
             }
        notifyListeners();
      });
    }
  }

  deleteComment(commentID, postId, {ownerId}) async {
    //   print('-===============>>>>>>>> : '); print(commentID);

    if (currentUserId != null) {
      await Firestore.instance
          .collection('posts')
          .document(postId)
          .collection('comments')
          .document(commentID)
          .delete();
      final post = _postList.firstWhere((post) => post.postId == postId);
      if(post.commentsCount > 0){
        post.commentsCount--;
        await Firestore.instance.collection('posts').document(postId).updateData({
          'commentsCount': post.commentsCount,
        }).then((value) async {
          //===============Activity Feed =====================
          if(post.userId != currentUserId) {
            var _querySnapshot = await Firestore.instance
                .collection('feeds')
                .document(ownerId)
                .collection('feedItems')
                .where('commentId', isEqualTo: commentID)
                .getDocuments();
            if (_querySnapshot.documents.length > 0) {
              Firestore.instance
                  .collection('feeds')
                  .document(ownerId)
                  .collection('feedItems')
                  .document(_querySnapshot.documents[0].documentID)
                  .delete();
            }
          }
          notifyListeners();
        });
      }
      }


  }

  undoComment(commentMap, postId) async {
    await Firestore.instance
        .collection('posts')
        .document(postId)
        .collection('comments')
        .document(commentMap['commentId'])
        .setData({
      'comment': commentMap['comment'],
      'userId': commentMap['userId'],
      'timeStamp': commentMap['timeStamp'],
      'commentId': commentMap['commentId']
    });

    final post = _postList.firstWhere((post) => post.postId == postId);

    post.commentsCount++;
    await Firestore.instance.collection('posts').document(postId).updateData({
      'commentsCount': post.commentsCount,
    }).then((value) {
      //======== Activity Feed =======
      //    if(post.userId != currentUserId) {
      Firestore.instance
          .collection('feeds')
          .document(post.userId)
          .collection('feedItems')
          .add({
        'type': 'comment',
        'comment': commentMap['comment'],
        'userId': commentMap['userId'],
        'commentId': commentMap['commentId'],
        'timeStamp': DateTime.now(),
        'postId': postId,
      });
      //     }
      notifyListeners();
    });
  }

  logout() {
    _postList = [];
    lastDocument = null;
    lastFetched = false;
  }
}
