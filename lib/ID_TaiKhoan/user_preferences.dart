import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyUserId = 'userId';

  static Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, id);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
  }
}
