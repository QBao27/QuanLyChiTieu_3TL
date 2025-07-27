import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/TaiKhoan/TaiKhoan.dart';

class LocalStorageService {
  static const String _userKey = 'user';

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);

    if (jsonString != null) {
      return User.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
