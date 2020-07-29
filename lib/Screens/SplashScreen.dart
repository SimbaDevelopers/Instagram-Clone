import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/SplashScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child:
           CircularProgressIndicator(),
//          Container(
//              height: 120.0,
//              width: 120.0,
//              decoration: BoxDecoration(
//                image: DecorationImage(
//                  image: AssetImage(
//                      'assets/images/logo.png'),
//                  fit: BoxFit.fill,
//                ),
//              ),
//            )
//          FittedBox(
//            child:
//
//            Container(
//              // margin: EdgeInsets.only(top: 150),
//              // height: 1000,
//              // width: 1000,
//              child: Image.asset('assets/images/splash1.png'),
//            ),
//          ),
            // Container(
            //   margin: EdgeInsets.only(top: 5),
            //   child: Text(
            //     "Instagram",
            //     style: TextStyle(fontSize: 60, fontFamily: 'Billabong'),
            //   ),
            // ),



      ),
    );
  }
}
