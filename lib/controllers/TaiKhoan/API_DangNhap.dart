

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/TaiKhoan/TaiKhoan.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:5112/api/Auth';

  /// Đăng nhập
  static Future<User?> login(String email, String password) async {
    final uri = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'EmailOrPhone': email,
        'MatKhau': password,
      }),
    );

    print('Request body: ${jsonEncode({'email': email, 'MatKhau': password})}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('❌ Login failed: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  /// Lấy thông tin người dùng theo ID
  static Future<User?> getUserById(int id) async {
    final uri = Uri.parse('$_baseUrl/$id');
    final response = await http.get(uri);

    print('Get user status: ${response.statusCode}');
    print('Get user response: ${response.body}');

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('❌ Get user failed: ${response.statusCode}');
      return null;
    }
  }

  static Future<bool> changePassword(int userId, String oldPassword, String newPassword) async {
    try {
      final uri = Uri.parse('$_baseUrl/change-password/$userId');

      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      print('🔁 Change password status: ${response.statusCode}');
      print('📦 Response body: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('❌ Lỗi đổi mật khẩu: $e');
      return false;
    }
  }
}

