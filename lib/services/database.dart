import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap);
  }
}
