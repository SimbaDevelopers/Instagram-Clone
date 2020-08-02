import 'package:flutter/material.dart';
import 'package:instagram/Pages/Profile.dart';

class ChatDetails extends StatelessWidget {
  ChatDetails(this.name,this.username,this.img,this.userId);
  String name,username,img,userId;
  bool mute_message=false,mute_video_chat=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            SwitchListTile(
              value: mute_message,
              onChanged: (bool value) {
                mute_message = !mute_message;
              },
              title: Text("Facebook"),
            ),
            SwitchListTile(
              value: mute_video_chat,
              onChanged: (value) {

                  mute_video_chat = !mute_video_chat;
              },
              title: Text("Twitter"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:Text("Shared",
                    style: TextStyle(fontSize: 16),),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:Text("See All",
                    style: TextStyle(fontSize: 15,color: Colors.blue),),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 10
              ),
              leading: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10
                ),
                child: CircleAvatar(
                  backgroundImage:img==null ?
                  AssetImage('assets/images/profile.jpeg') : NetworkImage(img),
                ),
              ),
              title: Text(username==null ? "" :username),
              onTap: () {
    Navigator.of(context).pushNamed(ProfilePage.routeName , arguments: {
      userId,
    });
              },
            ),
            Expanded(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.blue[400])),
                color: Colors.blue[400],
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(3),
                splashColor: Colors.blueAccent,
                onPressed: () {},
                child: Text(
                  ' Follow ',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
            Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Text("Restrict",style: TextStyle(
                fontSize: 16
              ),),
            ),
            Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Text("Report...",style: TextStyle(
                  fontSize: 16
              ),),
            ),
            Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Text("Block Account",style: TextStyle(
                  fontSize: 16
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
