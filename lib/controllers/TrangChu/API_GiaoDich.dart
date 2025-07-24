import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appquanlychitieu/models/TrangChu/GiaoDich.dart';

const String baseUrl = "http://10.0.2.2:5112/api/giaodich";

class ApiService {
  /// Lấy báo cáo tháng (summary + transactions)
  Future<MonthlyReport> getMonthlyReport({
    required int idTaiKhoan,
    int? month,
    int? year,
  }) async {
    // Xây dựng query string nếu có month/year
    final queryParams = <String, String>{};
    if (month != null) queryParams['month'] = month.toString();
    if (year  != null) queryParams['year']  = year.toString();

    final uri = Uri.parse("$baseUrl/by-tai-khoan/$idTaiKhoan")
        .replace(queryParameters: queryParams);
    print('🔗 Đang gọi: $uri');
    final response = await http.get(uri);
    print('✅ StatusCode: ${response.statusCode}');
    print('✅ Body: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return MonthlyReport.fromJson(body);
    } else if (response.statusCode == 404) {
      throw Exception('Không tìm thấy giao dịch cho tài khoản này.');
    } else {
      throw Exception('Lỗi khi tải báo cáo: ${response.statusCode}');
    }
  }

  // Xóa giao dịch (DELETE /api/giaodich/{id})
  Future<void> deleteGiaoDich(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception("Xóa thất bại: ${response.statusCode}");
    }
  }

  // Thêm giao dịch (vẫn dùng nếu bạn có endpoint POST /api/giaodich)
  Future<void> addGiaoDich(int idTaiKhoan, ThemGiaoDichDto gd) async {
    final response = await http.post(
      Uri.parse("$baseUrl/by-tai-khoan/$idTaiKhoan"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(gd.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Thêm giao dịch thất bại: ${response.statusCode}");
    }
  }


/// Cập nhật giao dịch (PUT /api/giaodich/{id})
  // Future<void> updateGiaoDich(GiaoDich gd) async {
  //   if (gd.id == null) throw Exception("ID giao dịch không được null.");
  //   final response = await http.put(
  //     Uri.parse('$baseUrl/${gd.id}'),
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(gd.toJson()),
  //   );
  //   if (response.statusCode != 200) {
  //     throw Exception("Cập nhật thất bại: ${response.statusCode}");
  //   }
  // }


}
