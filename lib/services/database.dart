import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethod {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("username", isGreaterThanOrEqualTo: username)
        .getDocuments();
  }

  getUserByUserEmail(String useremail) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: useremail)
        .getDocuments();
  }

  uploadUserInfo(userMap, userId) {
    String _userId;
    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;

      Firestore.instance
          .collection("users")
          .document(user.uid)
          .setData(userMap);
    });

  }
  editUserInfo(userMap , userId)  {
    Firestore.instance
        .collection("users")
        .document(userId)
        .updateData(userMap);
  }

  getcurrentUserId() async{
    String _uid;
    await FirebaseAuth.instance.currentUser().then((value) => _uid = value.uid);
    return _uid;
  }


  addNewPost(postMap) async {
     final docRef = await Firestore.instance
        .collection("posts")
         .add(postMap);

     Firestore.instance
         .collection("posts")
         .document(docRef.documentID)
         .updateData({
       'postId' : docRef.documentID,
     });
  }

}
