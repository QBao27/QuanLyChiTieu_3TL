import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/TaiKhoan/TaiKhoan.dart';

class ApiService {
  static const String _baseUrl = 'http://localhost:5112/api/Auth';

  static Future<User?> login(String email, String password) async {
    final uri = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'MatKhau': password,
      }),
    );

    print('Request body: ${jsonEncode({'email': email, 'password': password})}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Login failed: ${response.statusCode} - ${response.body}');
      return null;
    }
  }


  static Future<User?> getUserById(int id) async {
    final uri = Uri.parse('$_baseUrl/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Get user failed: ${response.statusCode}');
      return null;
    }
  }
}
