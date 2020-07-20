import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        getImage(true);
                      },
                    ),
                    Text(
                      'Instagram',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {},
                    ),
                    _image == null
                        ? Container()
                        : Image.file(
                            _image,
                            height: 300.0,
                            width: 300.0,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
