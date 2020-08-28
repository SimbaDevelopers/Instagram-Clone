import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/provider/UserInfo.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';

import 'TrimmerView.dart';

class AddStory extends StatefulWidget {
  static const routeName = '/AddStory';

  @override
  _AddStoryState createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  var _value = 'Image';
  var _selectedType ;

  File _video;
  File _image;
  bool isUploading = false;

  VideoPlayerController playerController = null;
  Future<void> _initializeVideoPlayerFuture;
  String _videoPath;
  final Trimmer _trimmer = Trimmer();
  var duration;

  Future getImage(String type) async {

  //  playerController.removeListener(() {});
    setState(() {
      _selectedType = null;
      _image = null;
      _video = null;
      if(!(playerController == null))
      if(playerController.value.initialized){
        //  playerController.dispose();
        playerController.pause();
        playerController = null;
      }
    });

    File image;
    File video;
    if (_value == "Image") {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if(image != null){
        setState(() {
          _image = image;
          _selectedType = _value;
        });
      }

    } else if(_value == "Video") {
      video = await ImagePicker.pickVideo(source: ImageSource.gallery);

      if(video != null){
        await _trimmer.loadVideo(videoFile: video);

        Navigator.of(context).pushNamed(TrimmerView.routeName , arguments: {
          'trimmer' : _trimmer,
          'saveTrimedVideo' : saveTrimedVideo
        });
      }
      else{
        setState(() {
          _selectedType = null;
          _image = null;
          _video = null;
        });
      }
    }
  }

  saveTrimedVideo( startValue , endValue) async {

    await _trimmer
        .saveTrimmedVideo(startValue: startValue, endValue: endValue)
        .then((value) {
      setState(() {
        duration = endValue - startValue;
        _videoPath = value;
        _video = File(_videoPath);
        _selectedType = _value;
        createVideo();
      });
    });

    return _videoPath;
  }

  sendTo(){
    if(_selectedType != null) {
      showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Divider(
                    indent: 160,
                    endIndent: 160,
                    thickness: 4,
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {
                      addStory("story");
                    },
                    icon: Text("Share to your Story"),
                  ),
                  IconButton(
                    onPressed: () {
                      addStory("CloseFriends");
                    },
                    icon: Text("Share to Close Friends"),
                  ),
//                  IconButton(
//                    onPressed: () {
//                      addStory("Public");
//                    },
//                    icon: Text("Share to Public"),
//                  )
                ],
              ),
            );
          });
    }
  }


  addStory(type ) async {
    Navigator.of(context).pop();
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
      if(docSnap.exists){
        final timeStamp = DateTime.now();
        Firestore.instance.collection('stories').document(user.uid).updateData({
          'timeStamp' : timeStamp,
          "File": FieldValue.arrayUnion([
            {
              'timeStamp': timeStamp,
              'storyURL' : _url,
              'storyType'  : type,
              'imageOrVideo' : _selectedType,
              'duration' : _selectedType == "Video" && duration != null ? duration : 0
            }
          ])});
      }else{
        await Firestore.instance.collection('stories').document(user.uid).setData({
          'timeStamp' : DateTime.now(),
          'File' : [
            {
              'timeStamp': DateTime.now(),
              'storyURL' : _url,
              'storyType'  : type,
              'imageOrVideo' : _selectedType,
              'duration' : _selectedType == "Video" && duration != null ? duration : 0
            }
          ],
          'profileImageURL' : currentUser.profileImageURL,
          'username' : currentUser.username,
          'userId' : user.uid,
        });
      }
    });
    setState(() {
      isUploading = false;
      Navigator.of(context).pop();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _video !=null ?
          playerController != null && playerController.value.initialized ? FittedBox(
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
                    height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - 55,
                    child: VideoPlayer(playerController),
                  ),
                ),
              ) : SizedBox.shrink()
              :Container(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - 55,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _image != null ? FileImage(_image) : AssetImage('assets/images/profile.jpeg')
              )
            )
            ,
          ),
          isUploading ? LinearProgressIndicator() : SizedBox(),
        ],
      ),
      bottomNavigationBar:/* Column(
        children: <Widget>[*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton(
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("Image"),
                      value: 'Image',
                    ),
                    DropdownMenuItem(
                      child: Text("Video"),
                      value: 'Video',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),

                IconButton(
                  onPressed:(){
                    getImage(_value);
                  },
                  icon: Icon(Icons.add_circle , color: Colors.white,),
                  iconSize: 70,
                ),
                IconButton(
                  onPressed:(){
                      sendTo();
                  },
                  icon: Text("send to"),
                  padding: EdgeInsets.all(5),
                  iconSize: 50,),

              ],
            ),
          ),

    );
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

  void dispose() {
    if(playerController == null){

    }
    else{
      playerController.removeListener(() {});
      playerController.dispose();
      print("siapose");
    }

    super.dispose();
  }
}


