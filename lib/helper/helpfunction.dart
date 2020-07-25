import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String sharedpreferenceloggedinkey = "ISLOGGEDINKEY";
  static String sharedpreferenceusernamekey = "USERNAMEKEY";
  static String sharedpreferenceuseremailkey = "USEREMAILKEY";

  static Future<bool> saveuserloggedinSharedPreferecne(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedpreferenceloggedinkey, isUserLoggedIn);
  }

  static Future<bool> saveusernameSharedPreferecne(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceusernamekey, username);
  }

  static Future<bool> saveuseremailSharedPreferecne(String useremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceuseremailkey, useremail);
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

  static Future<String> getuseremailSharedPreferecne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedpreferenceuseremailkey);
  }
}
