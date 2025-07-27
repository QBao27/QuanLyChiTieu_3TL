import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appquanlychitieu/models/TrangChu/GiaoDich.dart';

const String baseUrl = "http://localhost:5112/api/giaodich";

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


// Cập nhật giao dịch (PUT /api/giaodich/{id})
  Future<void> updateGiaoDich(int id, double soTien, String? moTa) async {
    final response = await http.put(
      Uri.parse('$baseUrl/by-id-update/$id'), // ✅ Đảm bảo đúng endpoint
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "soTien": soTien,
        "moTa": moTa,
      }),
    );

    if (response.statusCode == 200) {
      print("✅ Cập nhật thành công");
      return;
    }

    // Nếu lỗi, cố gắng parse response body
    dynamic error;
    try {
      error = json.decode(response.body);
    } catch (_) {
      error = {"message": response.body}; // fallback nếu không decode được
    }

    if (response.statusCode == 400) {
      if (error['errors'] != null) {
        final errors = error['errors'] as Map<String, dynamic>;
        final errorMessages = errors.entries.map((e) {
          final messages = (e.value as List).join(', ');
          return '${e.key}: $messages';
        }).join('\n');

        print("❌ Lỗi 400: $errorMessages");
        throw Exception("Lỗi yêu cầu:\n$errorMessages");
      }

      print("❌ Lỗi 400: ${error.toString()}");
      throw Exception("Yêu cầu không hợp lệ.");
    }

    if (response.statusCode == 404) {
      print("❌ Lỗi 404: Không tìm thấy giao dịch.");
      throw Exception("Không tìm thấy giao dịch.");
    }

    print("❌ Lỗi ${response.statusCode}: ${error.toString()}");
    throw Exception("Lỗi không xác định: ${response.statusCode}");
  }



}
