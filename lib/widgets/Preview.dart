import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram/Screens/TrimmerView.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:instagram/widgets/CameraView.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';


class PreviewScreen extends StatefulWidget{
  static const routeName = '/PreviewScreen';
  final String imgPath;
  final String type ;
  final String videoPath;

  PreviewScreen({this.imgPath , this.videoPath , this.type});

  @override
  _PreviewScreenState createState() => _PreviewScreenState(imgPath: imgPath, videoPath:  videoPath , type:  type);

}
class _PreviewScreenState extends State<PreviewScreen>{
   String imgPath;
   final String type ;
   final String videoPath;

  _PreviewScreenState({this.imgPath , this.videoPath , this.type});
   File _image;
   File _video;

   final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


   var _selectedType  ;
   bool isUploading = false;
   var duration;
   final Trimmer _trimmer = Trimmer();
   bool toCloseFriends = false;
   bool toFriends = false;


   VideoPlayerController playerController = null;

    var ctx;
   @override
  void initState() {
//     Future.delayed(Duration.zero).then((value) async {
       setFile();
//     });

     print("init------------------------1;");
     print(widget.type);

    // TODO: implement initState
    super.initState();
  }


  setFile( ) async{
    _selectedType  = widget.type;
    if(_selectedType == 'Image')
      setState(() {
        _image = File(widget.imgPath);
      });
    else if(_selectedType == 'Video'){
      setState(()  {
        _video =  File(widget.videoPath);

        print(_video);
        print('in video----------------------------------;');
      });
      if(_video != null){
        await _trimmer.loadVideo(videoFile: _video);

        Navigator.of(ctx).pushNamed(TrimmerView.routeName , arguments: {
          'trimmer' : _trimmer,
          'saveTrimedVideo' : saveTrimedVideo
        });
      }

    }

  }

   saveTrimedVideo( startValue , endValue) async {

     String _videoPath;
     await _trimmer
         .saveTrimmedVideo(startValue: startValue, endValue: endValue)
         .then((value) {
       setState(() {

         duration = endValue - startValue;
         print('------------duration ---------------');
         print(duration);
         _videoPath = value;
           _video = File(_videoPath);
           _selectedType = "Video";
         createVideo();
       });
     });

     return _videoPath;
   }

   void createVideo() {
     if (playerController == null ) {
       playerController = VideoPlayerController.file(
           _video)
//        ..addListener(listener)
         ..setVolume(1.0)
         ..initialize().then((value){
           playerController.setLooping(true);
           setState(() {});
         })..play();
       playerController.addListener(() { setState(() {});});

     }
   }

   //======================================================================

   sendTo(context){

     if(toCloseFriends == false && toFriends == false){
       _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text("Select Story Type ")));
       return;
     }
     else if(toCloseFriends == true && toFriends == true){
       _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text("Select only one type")));
       return;
     }
     else if(toCloseFriends){
       addStory("CloseFriends" , context);
     }else if(toFriends){
       addStory("story" , context);
     }
   }




   addStory(type , context ) async {
    // Navigator.of(context).pop();
     setState(() {
       isUploading = true;
     });
     UserModel currentUser =  Provider.of<UserInformation>(context , listen: false).user;
     var _url;
     if(_selectedType == "Image"){

       final ref = FirebaseStorage.instance.ref().child('stories').child(Timestamp.now().toString() + '.jpg');
       await ref.putFile(_image).onComplete;
       _url =  await ref.getDownloadURL();
     }else if(_selectedType == "Video") {

       StorageReference ref = FirebaseStorage.instance.ref().child('stories').child(Timestamp.now().toString());
       await ref.putFile(_video, StorageMetadata(contentType: 'video/mp4')).onComplete; //<- this content type does the trick
       _url = await ref.getDownloadURL();
     }


     await FirebaseAuth.instance.currentUser().then((user) async {
       final docSnap = await Firestore.instance.collection('stories').document(user.uid).get();
       final timeStamp = DateTime.now();
       var _uniqueKey = UniqueKey().toString();
       if(docSnap.exists){

         Firestore.instance.collection('stories').document(user.uid).updateData({
           'timeStamp' : timeStamp,
           'seenBy' : {},
           "File": FieldValue.arrayUnion([
             {
               'timeStamp': timeStamp,
               'storyURL' : _url,
               'storyType'  : type,
               'imageOrVideo' : _selectedType,
               'duration' : _selectedType == "Video" && duration != null ? duration : 0,
               'storyId' : _uniqueKey

             }
           ])});
       }else{
         await Firestore.instance.collection('stories').document(user.uid).setData({
           'timeStamp' : timeStamp,
           'File' : [
             {
               'timeStamp':  timeStamp,
               'storyURL' : _url,
               'storyType'  : type,
               'imageOrVideo' : _selectedType,
               'duration' : _selectedType == "Video" && duration != null ? duration : 0,
               'storyId' : _uniqueKey
             }
           ],
           'profileImageURL' : currentUser.profileImageURL,
           'username' : currentUser.username,
           'userId' : user.uid,
           'seenBy' : {}
         });
       }
       await Firestore.instance.collection('stories').document(user.uid).collection('userStories').document(_uniqueKey).setData({
         'seenBy' : {},
         'timeStamp':  timeStamp,
         'storyURL' : _url,
         'storyType'  : type,
         'imageOrVideo' : _selectedType,
         'duration' : _selectedType == "Video" && duration != null ? duration : 0,
         'storyId' : _uniqueKey
       });

     });


     setState(() {
       isUploading = false;
       Navigator.of(context).pop();
     });
   }

   //=========================================================================





  @override
  Widget build(BuildContext context) {
     ctx = context;
    //print(widget.videoPath);
    return Scaffold(
    //  backgroundColor: Colors.transparent,
//      appBar: AppBar(
//        automaticallyImplyLeading: true,
//      ),
    key: _scaffoldkey,
      body: /*_selectedType == 'Image'? */ Container(
        decoration: widget.imgPath == null ? BoxDecoration() :  BoxDecoration(
          image:  DecorationImage(
            image: FileImage(File(widget.imgPath)),
            fit: BoxFit.cover,
          )
        ),
          child: Container(
            child: Stack(
               children: <Widget>[
                 Positioned(
                   top: 0,
                   child: Container(
                     child:  _video == null?
                     SizedBox() : playerController != null && playerController.value.initialized ? FittedBox(
                       fit: BoxFit.cover,
                       child: InkWell(
                         onTap: (){
                           if (playerController.value.isPlaying) {
                             playerController.pause();
                           } else {
                             //  playerController.initialize();
                             playerController.play();
                           }
                         },
                         child: SizedBox(
                           width: MediaQuery.of(context).size.width ,
                           height: MediaQuery.of(context).size.height,
                           child: VideoPlayer(playerController),
                         ),
                       ),
                     ) : SizedBox.shrink(),
                   ),
                 ),
                 Positioned(
                   top: 20,
                   child: Row(
                     children: <Widget>[
                       GestureDetector(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  CameraView()),
                           );
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.close,size: 33,)),
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   top: 20,
                   left: 50,
                   child: Row(
                     children: <Widget>[
                       GestureDetector(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  CameraView()),
                           );
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.face,size: 33,)),
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   top: 20,
                   left: 100,
                   child: Row(
                     children: <Widget>[
                       GestureDetector(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  CameraView()),
                           );
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.link,size: 33,)),
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   top: 20,
                   left: 150,
                   child: Row(
                     children: <Widget>[
                       GestureDetector(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  CameraView()),
                           );
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.arrow_downward,size: 33,)),
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   top: 20,
                   left: 200,
                   child: Row(
                     children: <Widget>[
                       GestureDetector(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  CameraView()),
                           );
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.gif,size: 33,)),
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   top: 20,
                   left: 250,
                   child: Row(
                     children: <Widget>[
                       GestureDetector(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  CameraView()),
                           );
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.linear_scale,size: 33,)),
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   top: 20,
                   left: 300,
                   child: Row(
                     children: <Widget>[
                       GestureDetector(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  CameraView()),
                           );
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.text_fields,size: 33,)),
                       ),
                     ],
                   ),
                 ),
                   Positioned(
                     bottom: 25,
                     left: 20,
                     child: Row(children: <Widget>[
                       InkWell(
                         onTap: () {
                           setState(() {
                             if(toFriends){
                               toFriends = false;
                             }else{
                               if(toCloseFriends)
                                 toCloseFriends = false;
                               toFriends = true;
                             }
                           });
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.account_circle,size: 33, color: toFriends ? Colors.blue : Colors.white,)),
                       ),
                     ],
                     ),
                   ),
                 Positioned(
                   bottom: 25,
                   left: 35,
                   child: Row(children: <Widget>[
                     InkWell(
                       onTap : () {
                         setState(() {
                           if(toFriends){
                             toFriends = false;
                           }else{
                             if(toCloseFriends)
                               toCloseFriends = false;
                             toFriends = true;
                           }
                         });
                       },
                       child: Icon(
                         Icons.supervised_user_circle,size: 35,color: toFriends ? Colors.blue : Colors.white,
                       ),
                     ),
                   ],
                   ),
                 ),
                 Positioned(
                   bottom: 25,
                   left: 110,
                   child: Row(children: <Widget>[
                     InkWell(
                       onTap : (){
                         setState(() {
                           if(toCloseFriends){
                             toCloseFriends = false;
                           }else{
                             if(toFriends)
                               toFriends = false;
                             toCloseFriends = true;
                           }

                         });
                       },
                       child: Icon(
                         Icons.stars,size: 35,color: toCloseFriends ? Colors.blue : Colors.white,
                       ),
                     ),
                   ],
                   ),
                 ),
                 Positioned(
                   bottom: 10,
                   left: 12,
                   child: Text("Your Story",style: TextStyle(fontSize: 13,fontStyle: FontStyle.normal , color: toFriends ? Colors.blue : Colors.white,),),
                 ),
                 Positioned(
                   bottom: 10,
                   left: 90,
                   child: Text("Close Freinds",style: TextStyle(fontSize: 13,fontStyle: FontStyle.normal , color:  toCloseFriends ? Colors.blue : Colors.white),),
                 ),
                 Positioned(
                   bottom: 15,
                   right: 15,
                   child: Container(
                     height: 45,
                     child: RaisedButton(
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(25.0),
                           side: BorderSide(color: Colors.white)),
                       onPressed: () {
                         sendTo(context);
                       },
                       color: Colors.white,
                       textColor: Colors.white,
                       child: isUploading ? CircularProgressIndicator() : Text("Send".toUpperCase(),
                           style: TextStyle(fontSize: 13,color: Colors.black)),
                     ),
                   ),
                 ),
    ],
  ),
),
      ) ,
    );
  }

   void dispose() {
     if(playerController == null){

     }
     else{
       playerController.pause();
       playerController.removeListener(() {});
       playerController.dispose();
       print("siapose");
     }

     super.dispose();
   }
}