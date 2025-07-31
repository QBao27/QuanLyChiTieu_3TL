import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../models/DangKy/DangKy.dart';
import '../../models/DangKy/TaiKhoan.dart';


class TaiKhoanApi {
  static const String baseUrl = 'http://10.0.2.2:5112/api/DangKy';

  // Đăng ký tài khoản
  static Future<String?> dangKy(TaiKhoanDto dto) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/dangky'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      debugPrint("📤 Gửi: ${dto.toJson()}");
      debugPrint("📥 Status code: ${response.statusCode}");
      debugPrint("📥 Nội dung: ${response.body}");

      if (response.statusCode == 200) return null;

      final json = jsonDecode(response.body);
      return json['message'] ?? 'Lỗi không xác định';
    } catch (e) {
      return 'Lỗi kết nối tới máy chủ';
    }
  }


  // Đăng nhập tài khoản
  static Future<TaiKhoan?> dangNhap(String email, String matKhau) async {
    final response = await http.post(
      Uri.parse('$baseUrl/dangnhap'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'hoTen': '', // placeholder nếu API yêu cầu
        'email': email,
        'phone': null,
        'matKhau': matKhau,
      }),
    );

    if (response.statusCode == 200) {
      return TaiKhoan.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
