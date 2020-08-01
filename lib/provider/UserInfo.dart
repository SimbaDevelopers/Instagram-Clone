

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    FirebaseAuth.instance.currentUser().then((currentUser)  async{

      userId = currentUser.uid;
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
        print(docSnapshot['followersCount'].toString());
        user = UserModel.fromMap(snapshot: docSnapshot , followersList: followersList , followingsList:  followingsList);
      }
      else{
        print("docSnapshot is null");
      }
      notifyListeners();

    });


  }

  addFollowings(searchedUserId) async {
    try {
      var docSnap =  await Firestore.instance.collection('users')
          .document(user.userId);
      docSnap.updateData({
        'followingsMap.$searchedUserId': true,
      });
      user.followingsCount++;
      docSnap.updateData({'followingsCount' : user.followingsCount });
      docSnap.collection('followingsList').document(searchedUserId).setData({
        'userId' : searchedUserId,
      });

      user.followingList.add({
        'userId' : searchedUserId,
      });
      user.followingsMap[searchedUserId.toString()] = true;


      var searchedUserSnap = await Firestore.instance.collection('users').document(searchedUserId);
      searchedUserSnap.updateData({
        'followersMap.${user.userId}' :true
      });

      var searchedUsersFollowerCount ;
      await searchedUserSnap.get().then((value) {
        searchedUsersFollowerCount = value['followersCount'];
        searchedUserSnap.updateData({'followersCount' : searchedUsersFollowerCount+1});
      });
      searchedUserSnap.collection('followersList').document(user.userId).setData({
        'userId' : user.userId,
      });

      notifyListeners();



    }catch(error)
    {
      print('error : => ' + error.toString());
    }
  }


  unfollow( searchedUserId)async {

    try {
      var docSnap =  await Firestore.instance.collection('users')
          .document(user.userId);
      docSnap.updateData({
        'followingsMap.$searchedUserId':FieldValue.delete(),
      });
      user.followingsCount--;
      docSnap.updateData({'followingsCount' : user.followingsCount });
      docSnap.collection('followingsList').document(searchedUserId).delete();
      user.followingsMap.remove(searchedUserId.toString());
      user.followingList.removeWhere((item) => item['userId'] == searchedUserId);


      var searchedUserSnap = await Firestore.instance.collection('users').document(searchedUserId);
      searchedUserSnap.updateData({
        'followersMap.${user.userId.toString()}' :FieldValue.delete(),

      });

      searchedUserSnap.collection('followersList').document(user.userId).delete();

      var searchedUsersFollowerCount ;
      await searchedUserSnap.get().then((value) {
        searchedUsersFollowerCount = value['followersCount'];
        searchedUserSnap.updateData({'followersCount' : searchedUsersFollowerCount-1});
      });

      notifyListeners();



    }catch(error)
    {
      print('error : => ' + error.toString());
    }
  }

  logout(){
    user = new UserModel() ;
  }

  }
