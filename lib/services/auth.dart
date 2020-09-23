import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:instagram/model/user.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging  _firebaseMessaging = FirebaseMessaging();


  UserModel _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Future signinwithemailandpassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      configureRealtimePushNotification(firebaseUser);

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }

  configureRealtimePushNotification(user){
    _firebaseMessaging.getToken().then((token){
      Firestore.instance.collection('users').document(user.uid).updateData({'androidNotificationToken' : token});
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String , dynamic> msg) async {
        final String recipientId = msg['data']['recipient'];
        final String body  = msg['notification']['body'];

        if(recipientId == user.uid){
          print("======================================== notification ====================================");
          print(body);
        }

      }
    );

  }

  Future signupwithemailandpassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }



  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
