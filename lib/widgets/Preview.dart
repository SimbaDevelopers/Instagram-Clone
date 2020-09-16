import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram/widgets/CameraView.dart';
import 'package:path/path.dart';

class PreviewScreen extends StatefulWidget{
  final String imgPath;

  PreviewScreen({this.imgPath});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();

}
class _PreviewScreenState extends State<PreviewScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.transparent,
//      appBar: AppBar(
//        automaticallyImplyLeading: true,
//      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(widget.imgPath)),
            fit: BoxFit.cover,
          )
        ),
          child: Container(
            child: Stack(
               children: <Widget>[
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
                       GestureDetector(
                         onTap: () {
                         },
                         child: Padding(padding: const EdgeInsets.all(10),
                             child: Icon(Icons.account_circle,size: 33,)),
                       ),
                     ],
                     ),
                   ),
                 Positioned(
                   bottom: 25,
                   left: 35,
                   child: Row(children: <Widget>[
                     Icon(
                       Icons.supervised_user_circle,size: 35,
                     ),
                   ],
                   ),
                 ),
                 Positioned(
                   bottom: 25,
                   left: 110,
                   child: Row(children: <Widget>[
                     Icon(
                       Icons.stars,size: 35,
                     ),
                   ],
                   ),
                 ),
                 Positioned(
                   bottom: 10,
                   left: 12,
                   child: Text("Your Story",style: TextStyle(fontSize: 13,fontStyle: FontStyle.normal),),
                 ),
                 Positioned(
                   bottom: 10,
                   left: 90,
                   child: Text("Close Freinds",style: TextStyle(fontSize: 13,fontStyle: FontStyle.normal),),
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
                       onPressed: () {},
                       color: Colors.white,
                       textColor: Colors.white,
                       child: Text("Send to".toUpperCase(),
                           style: TextStyle(fontSize: 13,color: Colors.black)),
                     ),
                   ),
                 ),
    ],
  ),
),
      ),
    );
  }

}