import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/EditProfile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  File _image;

  void pickImage() async {
    File image;

    image = (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.save,
              color: Colors.deepPurple[400],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: _image == null
                            ? AssetImage('assets/images/profile.jpeg')
                            : FileImage(_image),
                        radius: 45,
                      ),
                      FlatButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: Text(
                          'Change Profile Photo',
                          style: TextStyle(
                              color: Colors.deepPurple[200], fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: nameController..text = "Teͥjaͣsͫ",
                  decoration: InputDecoration(
                      labelText: 'Name',
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Username',
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Website',
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Bio',
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Profile Information',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text('E-mail Address', style: TextStyle(color: Colors.grey)),
                SizedBox(
                  height: 4,
                ),
                Text('tejanghan@gmail.com'),
                Divider(color: Colors.grey),
                SizedBox(height: 8),
                Text('Phone Number', style: TextStyle(color: Colors.grey)),
                SizedBox(
                  height: 4,
                ),
                Text('+91 9081004787'),
                Divider(color: Colors.grey),
                SizedBox(height: 8),
                Text('Gender', style: TextStyle(color: Colors.grey)),
                SizedBox(
                  height: 4,
                ),
                Text('Male'),
                Divider(color: Colors.grey),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
