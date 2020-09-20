import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram/Screens/AddStory.dart';
import 'package:instagram/Screens/FollowersFollowingsScreen.dart';
import 'package:instagram/Screens/MainScreen.dart';
import 'package:instagram/Screens/StoryScreen.dart';
import 'package:instagram/Screens/TrimmerView.dart';
import 'package:instagram/Screens/UsernameScreen.dart';
import 'package:instagram/authenticate.dart';
import 'package:instagram/provider/PostList.dart';
import 'package:instagram/widgets/EditProfile.dart';
import 'package:instagram/widgets/Preview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'Pages/Activity.dart';
import 'Pages/Add.dart';
import 'Pages/Home.dart';
import 'Pages/Profile.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/SignupScreen.dart';
import 'Screens/SignupScreen.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/startupscreen.dart';
import 'Screens/CloseFriendsScreen.dart';
import 'Screens/UsernameScreen.dart';
import 'Pages/Search.dart';
import 'helper/helpfunction.dart';
import 'package:instagram/provider/UserInfo.dart';
import './Screens/LikesScreen.dart';
import './Screens/CommentsScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool ischecking = true;
  bool userIsLoggedIn;
  @override
  void initState() {
    getLoggedInState();

    super.initState();
  }

  getLoggedInState() async {
    await HelperFunction.getuserloggedinSharedPreferecne().then((value) {
      setState(() {
        ischecking = false;
        userIsLoggedIn = value;
      });
    });
  }

  gotoHomePage(context){
    Navigator.pushReplacement(
        context, MaterialPageRoute(
        settings: RouteSettings(name: HomePage.routeName),
        builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return 
      MultiProvider(
        providers: [
          ChangeNotifierProvider<PostList>(
              create : (ctx) =>  PostList(),
          ),
          ChangeNotifierProvider<UserInformation>(
            create: (ctx) => UserInformation(),
          ),


        ],
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: ischecking
              ? SplashScreen()
              : userIsLoggedIn != null
                  ? userIsLoggedIn ? HomePage() : Authenticate()
                  : Authenticate(),
          onGenerateRoute: (routeSettings) {
            if (routeSettings.name == SearchPage.routeName)
              return PageRouteBuilder(settings : routeSettings, pageBuilder:(_, __, ___) => SearchPage() , transitionDuration: Duration(seconds: 0),);

            if (routeSettings.name == HomePage.routeName)
              return PageRouteBuilder(settings : routeSettings,pageBuilder:(_, __, ___) => HomePage() , transitionDuration: Duration(seconds: 0),);

            if (routeSettings.name == ProfilePage.routeName)
              return PageRouteBuilder(settings : routeSettings ,  pageBuilder:(_, __, ___) => ProfilePage() , transitionDuration: Duration(seconds: 0),);

            if (routeSettings.name == ActivityPage.routeName)
              return PageRouteBuilder(settings : routeSettings,pageBuilder:(_, __, ___) => ActivityPage() , transitionDuration: Duration(seconds: 0),);

            if (routeSettings.name == StoryScreen.routeName + 'Right Swipe')
            return PageTransition(
              child: StoryScreen(),
              type: PageTransitionType.leftToRight,
              settings: routeSettings,
            );

            if (routeSettings.name == StoryScreen.routeName + 'Left Swipe')
              return PageTransition(
                child: StoryScreen(),
                type: PageTransitionType.rightToLeft,
                settings: routeSettings,
              );

            if (routeSettings.name == StoryScreen.routeName )
              return PageTransition(
                child: StoryScreen(),
                type: PageTransitionType.fade,
                settings: routeSettings,
              );
            return null;
          },

          routes: {
            // SignUpScreen.routeName: (context) => SignUpScreen(),
            LoginOrSignup.routeName: (context) => LoginOrSignup(),
            // Login_Screen.routName: (context) => Login_Screen(),
            MainScreen.routeName: (context) => MainScreen(),
            UsernameScreen.routeName: (context) => UsernameScreen(),
//        HomePage.routeName: (ctx) => HomePage(),
//        SearchPage.routeName: (ctx) => SearchPage(),
            AddPage.routeName: (ctx) => AddPage(),
//       ActivityPage.routeName: (ctx) => ActivityPage(),
//        ProfilePage.routeName: (ctx) => ProfilePage(),
            SplashScreen.routeName: (ctx) => SplashScreen(),
            EditProfile.routeName: (ctx) => EditProfile(),
            FollowersFollowingsScreen.routeName: (ctx) => FollowersFollowingsScreen(),
            CloseFriendsScreen.routeName: (ctx) => CloseFriendsScreen(),
            LikesScreen.routeName: (ctx) => LikesScreen(),
            CommentsScreen.routeName: (ctx) => CommentsScreen(),
            AddStory.routeName: (ctx) => AddStory(),
            TrimmerView.routeName: (ctx) => TrimmerView(),
            PreviewScreen.routeName: (ctx) => PreviewScreen(),
//            StoryScreen.routeName: (ctx) => StoryScreen(key: UniqueKey(),),
          },
        ),
      );

  }
}

class blank extends StatefulWidget {
  @override
  _blankState createState() => _blankState();
}

class _blankState extends State<blank> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
