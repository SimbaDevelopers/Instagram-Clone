import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/authenticate.dart';
import 'package:instagram/services/auth.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<HomePage> {
  AuthMethod authMethod = new AuthMethod();
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
                      style: TextStyle(fontSize: 30.0),
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
        body: Container(
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.blue)),
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(15),
            splashColor: Colors.blueAccent,
            onPressed: () {
              authMethod.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Text(
              "Sign Out",
            ),
          ),
        ),
      ),
    );
  }
}
