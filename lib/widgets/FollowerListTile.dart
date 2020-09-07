import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';

class FollowerListTile extends StatefulWidget {

  final String followersId , userId;
  FollowerListTile({this.followersId , this.userId});
  @override
  _FollowerListTileState createState() => _FollowerListTileState();
}

class _FollowerListTileState extends State<FollowerListTile> {
  bool isFollowing;
  String currentUserId;
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        currentUserId = user.uid ;
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: Firestore.instance.collection('users').document(widget.followersId).get(),
     builder: (context ,snapshot){
       if(snapshot.connectionState == ConnectionState.waiting) return Container();
       if(!snapshot.hasData) return SizedBox();
       if(!(currentUserId == null))
//         print("============================================");
//         print(snapshot.data.data['userId']);
         if(snapshot.data['followersMap'] == {} ||snapshot.data['followersMap'] !=null )
       isFollowing = snapshot.data['followersMap'].containsKey(currentUserId);
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: snapshot.data['profileImageURL'] ==null || snapshot.data['profileImageURL'] == '' ?  AssetImage(
                      'assets/images/profile.jpeg',
                    ) : NetworkImage(snapshot.data['profileImageURL']),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: snapshot.data['name']  == null || snapshot.data['name'] == '' ? Text("") : Text(snapshot.data['name'] ),
                      ),
                      snapshot.data['username']  == null ? Text('') : Text(snapshot.data['username'] )
                    ],
                  ),
                  Spacer(),
                  currentUserId == null ? SizedBox() : currentUserId == widget.userId ?
                  FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.deepPurple[400])),
                      color: Colors.deepPurple[400],
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(7),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        if(isFollowing){
                          Provider.of<UserInformation>(context , listen: false).unfollow(widget.followersId);
                          setState(() {
                            isFollowing = !isFollowing;
                          });
                        }else{
                          Provider.of<UserInformation>(context , listen: false).addFollowings(widget.followersId);
                          setState(() {
                            isFollowing = !isFollowing;
                          });

                        }
                      },
                      child: isFollowing == null ? Text('',style: TextStyle(fontSize: 13),) : isFollowing ? Text(
                        ' Following ' ,
                        style: TextStyle(fontSize: 13),
                      ) : Text(
                        ' Follow ' ,
                        style: TextStyle(fontSize: 13),
                      )
                  ) : SizedBox(),
                ],
              ),
            ),
            Divider(color: Colors.blueGrey,)
          ],
        );
     },
    );
  }
}
