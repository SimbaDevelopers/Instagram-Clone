import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/helper/helpfunction.dart';
import 'package:instagram/services/database.dart';

void main() => runApp(AddPage());

class AddPage extends StatefulWidget {
  static const routeName = '/AddPage';

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseMethod databaseMethod = new DatabaseMethod();

  bool facebook = false;
  bool twitter = false;
  bool tumblr = false;
  var _value = 'Gallery';
  var captionController = TextEditingController();
  bool isUploading = false;

   TextEditingController locationController = TextEditingController();

  File _image;
  String _userId;
  String posturl;

  void pickImage(type) async {
    File image;
    if (type == 'Camera') {
      image = (await ImagePicker.pickImage(source: ImageSource.camera)) as File;
    } else if (type == 'Gallery') {
      image =
          (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
    }
    setState(() {
      _image = image;
    });
  }

  addPost( context) async {
    setState(() {
      isUploading = true;
    });
    print('AddPost');

    await HelperFunction.getuserIdSharedPreferecne().then((value) async {
      _userId = value;
        if(_image == null){
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Please Select Image..." , style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.black,),);

        }else{
          final ref = FirebaseStorage.instance.ref().child(_userId).child('posts').child(Timestamp.now().toString() + '.jpg');
          await ref.putFile(_image).onComplete;
          final _url =  await ref.getDownloadURL();

          Map<String,Object> postMap = {
            'userId'  : _userId,
            'caption' : captionController.text.trim(),
            'createdAt' : DateTime.now(),
            'postURL' : _url,
            'location': locationController.text.trim(),
          };

          databaseMethod.addNewPost(postMap);
          posturl = _url.toString();
          _image = null;
          captionController.text= null;
          locationController.text = null;

          setState(() {
            isUploading = false;
          });

        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'New Post',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          DropdownButton(
            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("Gallery"),
                value: 'Gallery',
              ),
              DropdownMenuItem(
                child: Text("Camera"),
                value: 'Camera',
              ),
            ],
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
          FlatButton(
              onPressed: () { addPost(context); },
              child: Text(
                'Share',
                style: TextStyle(color: Colors.deepPurple[300]),
              ))
        ],
      ),
      body: isUploading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/profile.jpeg'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: captionController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Write a caption...',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide:
                          //       BorderSide(color: Colors.grey, width: 1.0),
                          // ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pickImage(_value);
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey)),
                      child: _image != null
                          ? Image.file(
                              _image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Text('Select Image'),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Tag People',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Add Location..',
                  labelStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  // ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  // ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Also post to ',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Container(
              width: double.infinity,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  SwitchListTile(
                    value: facebook,
                    onChanged: (value) {
                      setState(() {
                        facebook = !facebook;
                      });
                    },
                    title: Text("Facebook"),
                  ),
                  SwitchListTile(
                    value: twitter,
                    onChanged: (value) {
                      setState(() {
                        twitter = !twitter;
                      });
                    },
                    title: Text("Twitter"),
                  ),
                  SwitchListTile(
                    value: tumblr,
                    onChanged: (value) {
                      setState(() {
                        tumblr = !tumblr;
                      });
                    },
                    title: Text("Tumblr"),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'Advanced settings ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
