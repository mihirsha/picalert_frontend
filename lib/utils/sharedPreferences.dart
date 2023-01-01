// ignore_for_file: file_names, non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences{
  static SharedPreferences? _preferences;

  static const _keytoken = "token";
  static const _keyUsername = "Username";

  static Future init() async => 
          _preferences = await SharedPreferences.getInstance();
  
  static Future setToken(String token) async => 
          await _preferences?.setString(_keytoken, token);
  

  static String? getToken() => _preferences?.getString(_keytoken);


  static Future setUsername(String Username) async => 
          await _preferences?.setString(_keyUsername, Username);

  static String? getUsername() => _preferences?.getString(_keyUsername);
}