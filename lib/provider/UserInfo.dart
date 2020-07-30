

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/helper/helpfunction.dart';

import 'package:instagram/model/user.dart';


class UserInformation with ChangeNotifier{

  UserModel user ;
  String userId;


  Future<Null> getUserInfo () async{
    var docSnapshot;
    var followingsListSnapshot;
    var followersListSnapshot;
    List<Map> followingsList = [];
    List<Map> followersList = [];
    userId = await HelperFunction.getuserIdSharedPreferecne();
    print('user id at provider :  ' + userId);

    followingsListSnapshot = await Firestore.instance.collection('users').document(userId).collection('followingsList').getDocuments();
    if(followingsListSnapshot.documents.length != 0){
      for (DocumentSnapshot documentSnapshot in followingsListSnapshot.documents) {
        followingsList.add(documentSnapshot.data);
      }
    }

    followersListSnapshot = await Firestore.instance.collection('users').document(userId).collection('followersList').getDocuments();
    if(followersListSnapshot.documents.length != 0){
      for (DocumentSnapshot documentSnapshot in followersListSnapshot.documents) {
        followersList.add(documentSnapshot.data);
      }
    }
   docSnapshot =  await Firestore.instance.collection('users').document(userId).get();
   if(docSnapshot.data != null)
     {
        user = UserModel.fromMap(snapshot: docSnapshot , followersList: followersList , followingsList:  followingsList);
     }
   else{
     print("docSnapshot is null");
   }
   notifyListeners();
  }
}