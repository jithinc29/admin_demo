import 'package:shared_preferences/shared_preferences.dart';

class UserSharedpreference
{
  static late SharedPreferences _preferences;

  static Future init()async=>_preferences=await SharedPreferences.getInstance();

  static Future setUID(String uid)async=>await _preferences.setString("uid", uid);
  static String? getUID()=>_preferences.getString("uid");
  static Future setName(String name)async=>await _preferences.setString("name", name);
  static String? getName()=>_preferences.getString("name");
}