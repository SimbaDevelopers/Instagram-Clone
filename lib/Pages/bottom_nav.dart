import 'package:flutter/material.dart';

import '../Pages/Activity.dart';
import '../Pages/Add.dart';
import '../Pages/Home.dart';
import '../Pages/Profile.dart';
import '../Pages/Search.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = '/MainScreen';
  bool isHomePage = false;
  bool isSearchPage = false;
  bool isActivityPage = false;
  bool isProfilePage = false;
  var context ;

  String pageName= 'HomePage';
  BottomNavigation(name , ctx){
    context = ctx;
    pageName = name;
    switch(name){
      case 'HomePage' : isHomePage = !isHomePage; break;
      case 'SearchPage' : isSearchPage = !isSearchPage; break;
      case 'ActivityPage' : isActivityPage = !isActivityPage; break;
      case 'ProfilePage' : isProfilePage = !isProfilePage ; break;


    }
  }
  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {






  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          GestureDetector(
            onTap: (){
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("temporary use back button for go to home page..." , style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.black,
              ));
             // Navigator.popUntil(context, ModalRoute.withName(HomePage.routeName));
//              Navigator.of(widget.context).pushNamed(HomePage.routeName);
            },
            child: Icon(Icons.home , size: 35, color: widget.isHomePage ? Colors.white : Colors.grey,),
          ),
          GestureDetector(
            onTap: (){
              if(!widget.isSearchPage)
                Navigator.of(widget.context).pushNamed(SearchPage.routeName);
            },
            child: Icon(Icons.search, size: 35, color: widget.isSearchPage ? Colors.white : Colors.grey,),
          ),
          GestureDetector(
            onTap: (){

              Navigator.of(widget.context).pushNamed(AddPage.routeName);
            },
            child: Icon(Icons.add, size: 35,color: Colors.grey,),
          ),
          GestureDetector(
            onTap: (){
              if(!widget.isActivityPage)
                Navigator.of(widget.context).pushNamed(ActivityPage.routeName);
            },
            child: Icon(Icons.favorite_border, size: 35,color:widget.isActivityPage ? Colors.white : Colors.grey,),
          ),
          GestureDetector(
            onTap: (){
              if(!widget.isProfilePage)
                Navigator.of(widget.context).pushNamed(ProfilePage.routeName);
            },
            child: Icon(Icons.supervised_user_circle, size: 35, color:widget.isProfilePage ? Colors.white : Colors.grey,),
          ),

        ],
      ),
    );

//      Scaffold(
//      body: Text('tejas'),
//      tabs[_currentIndex],
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentIndex,
//        type: BottomNavigationBarType.fixed,
//        selectedItemColor: Colors.white,
//        backgroundColor: Colors.black,
//        iconSize: 30,
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.home,
//              ),
//              title: Text(''),
//              backgroundColor: Colors.white),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.search),
//              title: Text(''),
//              backgroundColor: Colors.white),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.add),
//              title: Text(''),
//              backgroundColor: Colors.white),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.favorite),
//              title: Text(''),
//              backgroundColor: Colors.white),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.supervised_user_circle),
//              title: Text(''),
//              backgroundColor: Colors.white),
//        ],
//        onTap: (index) {
//          setState(() {
//            if (index == 2) {
//              Navigator.of(context).pushNamed(AddPage.routeName);
//            } else {
//              _currentIndex = index;
//            }
//          });
//        },
//      ),
 //   );
  }
}
