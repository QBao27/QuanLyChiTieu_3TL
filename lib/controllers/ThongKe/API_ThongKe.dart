// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/TrangChu/GiaoDich.dart';
//
// class GiaoDichService {
//   // 👉 Bắt buộc: Dùng 10.0.2.2 thay localhost nếu chạy trên Android Emulator
//   final String _baseUrl = 'http://10.0.2.2:5112/api/ThongKe';
//
//   Future<List<GiaoDich>> getGiaoDichByTaiKhoan(int idTaiKhoan) async {
//     final url = '$_baseUrl/by-tai-khoan/$idTaiKhoan';
//
//     print('--------------------------------------');
//     print('🔗 GỌI API LẤY GIAO DỊCH');
//     print('🔗 FULL URL : $url');
//     print('🔗 BASE URL : $_baseUrl');
//     print('🔗 PARAM idTaiKhoan: $idTaiKhoan');
//     print('--------------------------------------');
//
//     final headers = {'Content-Type': 'application/json'};
//     print('📡 Headers: $headers');
//
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: headers,
//       );
//
//       print('✅ HTTP StatusCode: ${response.statusCode}');
//       print('✅ HTTP Raw Body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         print('✅ ĐÃ PARSE JSON: $jsonData');
//
//         final result = (jsonData as List)
//             .map((e) => GiaoDich.fromJson(e))
//             .toList();
//
//         print('✅ SỐ GIAO DỊCH LẤY ĐƯỢC: ${result.length}');
//         return result;
//       } else {
//         print('❌ LỖI HTTP ${response.statusCode}');
//         throw Exception('Failed to load giao dich. Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('❌ LỖI NGOẠI LỆ: $e');
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/ThongKe/ThongKe_Models.dart';


class GiaoDichService {
  // ✅ Đây mới đúng với Controller của bạn:
  final String _baseUrl = 'http://localhost:5112/api/ThongKe';

  Future<List<GiaoDich>> getGiaoDichByTaiKhoan(int idTaiKhoan) async {
    final url = '$_baseUrl/by-tai-khoan/$idTaiKhoan';
    print('🔗 Đang gọi: $url');

    final response = await http.get(Uri.parse(url));

    print('✅ StatusCode: ${response.statusCode}');
    print('✅ Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((e) => GiaoDich.fromJson(e)).toList();
    } else {
      throw Exception('Lỗi lấy GiaoDich: ${response.statusCode}');
    }
  }
}
