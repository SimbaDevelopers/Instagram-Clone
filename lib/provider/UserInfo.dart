import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/model/user.dart';


class UserInformation with ChangeNotifier{

  UserModel user ;
  String userId;

  Future<Null> getUserInfo () async{
    var docSnapshot;
    var followingsListSnapshot;
    var followersListSnapshot;
    var closeFriendsListSnapshot;
//    List<Map> followingsList = [];
//    List<Map> followersList = [];
//    List<Map> closeFriendsList = [];
    FirebaseAuth.instance.currentUser().then((currentUser)  async{
      userId = currentUser.uid;
//      followingsListSnapshot = await Firestore.instance.collection('users').document(userId).collection('followingsList').getDocuments();
//      if(followingsListSnapshot.documents.length != 0){
//        for (DocumentSnapshot documentSnapshot in followingsListSnapshot.documents) {
//          followingsList.add(documentSnapshot.data);
//        }
//      }
//
//      followersListSnapshot = await Firestore.instance.collection('users').document(userId).collection('followersList').getDocuments();
//      if(followersListSnapshot.documents.length != 0){
//        for (DocumentSnapshot documentSnapshot in followersListSnapshot.documents) {
//          followersList.add(documentSnapshot.data);
//        }
//      }
//
//      closeFriendsListSnapshot = await Firestore.instance.collection('users').document(userId).collection('closeFriendsList').getDocuments();
//      if(closeFriendsListSnapshot.documents.length != 0){
//        for (DocumentSnapshot documentSnapshot in closeFriendsListSnapshot.documents) {
//          closeFriendsList.add(documentSnapshot.data);
//        }
//      }
      docSnapshot =  await Firestore.instance.collection('users').document(userId).get();
      if(docSnapshot.data != null)
      {
        user = UserModel.fromMap(snapshot: docSnapshot /*, followersList: followersList , followingsList:  followingsList , closeFriendsList: closeFriendsList*/);
      }
      else{
      //  print("docSnapshot is null");
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
//      docSnap.collection('followingsList').document(searchedUserId).setData({
//        'userId' : searchedUserId,
//      });
//
//      user.followingList.add({
//        'userId' : searchedUserId,
//      });
      user.followingsMap[searchedUserId.toString()] = true;
      var searchedUserSnap =  Firestore.instance.collection('users').document(searchedUserId);
      searchedUserSnap.updateData({
        'followersMap.${user.userId}' :true
      });

      var searchedUsersFollowerCount ;
      await searchedUserSnap.get().then((value) {
        searchedUsersFollowerCount = value['followersCount'];
        searchedUserSnap.updateData({'followersCount' : searchedUsersFollowerCount+1});
      });
//      searchedUserSnap.collection('followersList').document(user.userId).setData({
//        'userId' : user.userId,
//      });

      //======== Activity Feed =======
      Firestore.instance.collection('feeds').document(searchedUserId).collection('feedItems').add({
        'type' : 'follower',
        'userId' : userId,
        'timeStamp' : DateTime.now(),
      });
      notifyListeners();
    }catch(error)
    {
     // print('error : => ' + error.toString());
    }
  }

  unfollow( searchedUserId)async {

    try {
      var docSnap =  await Firestore.instance.collection('users')
          .document(user.userId);
      docSnap.updateData({
        'followingsMap.$searchedUserId':FieldValue.delete(),
      });
      if(user.followingsCount >0)
       user.followingsCount--;
      docSnap.updateData({'followingsCount' : user.followingsCount });
   //   docSnap.collection('followingsList').document(searchedUserId).delete();
      user.followingsMap.remove(searchedUserId.toString());
//      user.followingList.removeWhere((item) => item['userId'] == searchedUserId);
      var searchedUserSnap = await Firestore.instance.collection('users').document(searchedUserId);
      searchedUserSnap.updateData({
        'followersMap.${user.userId.toString()}' :FieldValue.delete(),
      });
  //    searchedUserSnap.collection('followersList').document(user.userId).delete();
      var searchedUsersFollowerCount ;
      await searchedUserSnap.get().then((value) {
        searchedUsersFollowerCount = value['followersCount'];
        if(searchedUsersFollowerCount>0)
          searchedUserSnap.updateData({'followersCount' : searchedUsersFollowerCount-1});
      });
      notifyListeners();
    }catch(error)
    {
    //  print('error : => ' + error.toString());
    }
  }

  addCloseFriend( friendsId) async{
    try {
      var docSnap = await Firestore.instance.collection('users')
          .document(user.userId);
      docSnap.updateData({
        'closeFriendsMap.$friendsId': true,
      });
      user.closeFriendsMap[friendsId.toString()] = true;
      user.closeFriendsCount++;
      docSnap.updateData({'closeFriendsCount': user.closeFriendsCount});
//      user.closeFriendsList.add({
//        'userId': friendsId,
//      });
//      docSnap.collection('closeFriendsList').document(friendsId).setData({
//        'userId': friendsId,
//      });
      var friendsSnap = await Firestore.instance.collection('users')
          .document(friendsId);
       friendsSnap.updateData({
        'whoAddedUinCFsMap.${user.userId}': true
      });
      notifyListeners();
    }
    catch(err){
   //   print("Error in addClose Friend : " + err);
    }
  }


  removeCloseFriend(friendsId)async {
    try {
      var docSnap = await Firestore.instance.collection('users')
          .document(user.userId);
      docSnap.updateData({
        'closeFriendsMap.$friendsId': FieldValue.delete(),
      });
      user.closeFriendsMap.remove(friendsId.toString());
      if(user.closeFriendsCount >0)
          user.closeFriendsCount--;
      docSnap.updateData({'closeFriendsCount': user.closeFriendsCount});
//      docSnap.collection('closeFriendsList').document(friendsId).delete();
//      user.closeFriendsList.removeWhere((item) =>
//      item['userId'] == friendsId);
      var friendsSnap = await Firestore.instance.collection('users')
          .document(friendsId);
      friendsSnap.updateData({
        'whoAddedUinCFsMap.${user.userId.toString()}': FieldValue.delete(),
      });
      notifyListeners();
    }
    catch(err){}
    }
  logout(){
    user = new UserModel() ;
  }

}

