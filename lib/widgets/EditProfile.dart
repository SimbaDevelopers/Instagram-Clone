import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/helper/constants.dart';
import 'package:instagram/services/database.dart';
import '../helper/helpfunction.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/EditProfile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  File _image;


  String _name;
  String _userName ;
  String imageurl = '';
  String _userId ;
  String _website;
  String _bio;
  String _phoneNumber;
  String _gender;
  String _email;

  bool isUploading = false;

  DatabaseMethod databaseMethod = new DatabaseMethod();


 @override
  void initState() {
     getUserInfo();
    super.initState();
  }

  void getUserInfo() async {

    await HelperFunction.getusernameSharedPreferecne().then((value) {
        setState(() {

          _userName = value;
        });
      });

    await FirebaseAuth.instance.currentUser().then((value) { _userId = value.uid;

    print(_userId);

    Firestore.instance.collection('users').document(_userId).get().then((value) async{
      _website = value.data['website'];
      _bio = value.data['bio'];
      _gender = value.data['gender'];
      _name = value.data['name'];
      _phoneNumber = value.data['phoneNumber'];
      _email = value.data['email'];

      imageurl= value.data['profileImageURL'].toString();

      print( 'image url ' + value.data['profileImageURL'].toString());

      setState(() {
      });
    });



    });
//    await HelperFunction.getuserIdSharedPreferecne().then((value)  {
//
//      _userId = value;
//
//
//    });






  }


  editUserInfo() async {
    final FormState form = _formKey.currentState;
    print('click');
   if( form.validate()){
       setState(() {
         isUploading=true;
       });
       if(_image == null) {

       }
       else {

         //============================  Upload Image to Firebase Storage  ===================================

         final ref = FirebaseStorage.instance.ref().child(_userId).child('ProfileImage').child(_userId + '.jpg');
         await ref.putFile(_image).onComplete;
         final _url =  await ref.getDownloadURL();
         await Firestore.instance
             .collection('users')
             .document(_userId)
             .updateData({

           'profileImageURL': _url,
         });

         imageurl = _url.toString();
         Constants.imgpro=imageurl;
         _image = null;
       }

       //===========================   upload user Info into database =========================================

       Map<String, String> userInfoMap = {
         'name' :  nameController.text.toString().trim(),
         "username": userNameController.text.trim(),
         'website' : websiteController.text.toString().trim(),
         'bio' : bioController.text.toString().trim(),
       'phoneNumber' :phoneNoController.text.toString().trim() ,

       };


       _website = websiteController.text.toString().trim();
       _bio = bioController.text.toString().trim();
       _name = nameController.text.toString().trim();
       _phoneNumber =phoneNoController.text.toString().trim();
      _userName = userNameController.text.trim();


       databaseMethod.editUserInfo(userInfoMap, _userId);

      setState(() {
        isUploading = false;

      });

         _scaffoldKey.currentState.showSnackBar(new SnackBar(
           content: new Text("Profile is Updated" , style: TextStyle(color: Colors.white),),
           backgroundColor: Colors.black,

       ));



     }

  }

  void pickImage() async {


    final image = await ImagePicker.pickImage(source: ImageSource.gallery );

    setState(() {
      _image = image;
      print('_image ' );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: <Widget>[
          InkWell(
            onTap: editUserInfo,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(

                Icons.save,
                color: Colors.deepPurple[400],
                size: 35,
              ),
            ),
          )
        ],
      ),
      body: isUploading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
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
                        backgroundImage: _image == null ? imageurl == '' ? AssetImage('assets/images/profile.jpeg')   : NetworkImage(imageurl) : FileImage(_image),

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
                  controller: _name == null ? nameController :  nameController..text = _name,
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
                  controller: _userName == null ? userNameController : userNameController..text = _userName,
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
                  controller: _website == null ? websiteController : websiteController..text = _website,
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
                    controller: _bio == null ? bioController : bioController..text= _bio,
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
                Text('$_email'),
                Divider(color: Colors.grey),
                SizedBox(height: 8),
                Text('Phone Number', style: TextStyle(color: Colors.grey)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(

//                        validator: (value) {
//                          return value==null ? null : value.length == 10 ? null : 'Enter a valid number';
//                        },
                        decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.number,

                        controller: _phoneNumber == null ? phoneNoController: phoneNoController..text = _phoneNumber,
                      ),
                    ],
                  ),
                ),
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


//Teͥjaͣsͫ
