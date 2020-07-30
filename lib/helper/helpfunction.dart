import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String sharedpreferenceloggedinkey = "ISLOGGEDINKEY";
  static String sharedpreferenceusernamekey = "USERNAMEKEY";
  static String sharedpreferenceuseremailkey = "USEREMAILKEY";
  static String sharedpreferenceuseruidKey= "USERIDKEY";
  static String profileImageUrlKey = 'IMAGEURLKEY';
  static String sharedpreferencenamekey = 'NAMEKEY';
  static String  sharedpreferenceuserbiokey = 'BIOKEY';


  static Future<bool> saveuserloggedinSharedPreferecne(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedpreferenceloggedinkey, isUserLoggedIn);
  }

  static Future<bool> saveusernameSharedPreferecne(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceusernamekey, username);
  }
  static Future<bool> savenameSharedPreferecne(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferencenamekey, name);
  }

  static Future<bool> saveuseremailSharedPreferecne(String useremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceuseremailkey, useremail);
  }
  static Future<bool> saveuserbioSharedPreferecne(String userbio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceuserbiokey, userbio);
  }

  //
  static Future<bool> getuserloggedinSharedPreferecne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedpreferenceloggedinkey);
  }

  static Future<String> getusernameSharedPreferecne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedpreferenceusernamekey);
  }
  static Future<String> getnameSharedPreferecne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedpreferencenamekey);
  }

  static Future<String> getuseremailSharedPreferecne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedpreferenceuseremailkey);
  }
  static Future<String> getuserbioSharedPreferecne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedpreferenceuserbiokey);
  }

  static Future<bool> saveuserIDinSharedPreferecne(
      String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceuseruidKey, userId);
  }

  static Future<String> getuserIdSharedPreferecne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedpreferenceuseruidKey);
  }

  static Future<bool> saveProfileImageUrlSharedPreference(
      String imageurl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(profileImageUrlKey, imageurl);
  }

  static Future<String> getProfileImageUrlSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(profileImageUrlKey);
  }

}
