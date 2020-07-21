import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/widgets/PostHomeScreen.dart';
import 'package:instagram/widgets/storybar.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<HomePage> {
  File _image;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: SafeArea(
            child: Container(
              color: Colors.black,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            getImage(true);
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Instagram',
                          style: TextStyle(
                              fontSize: 25.0, fontFamily: 'Billabong'),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                    // _image == null
                    //     ? Container()
                    //     : Image.file(
                    //         _image,
                    //         height: 300.0,
                    //         width: 300.0,
                    //       ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              StoryBar(),
              Divider(
                color: Colors.white,
              ),
              PostHome(),
            ],
          ),
        ),
      ),
    );
  }
}

// ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: 60,
//                   itemBuilder: (context, index) {
//                     return Text('Some text');
//                   })
