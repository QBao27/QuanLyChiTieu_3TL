import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appquanlychitieu/models/TrangChu/GiaoDich.dart';

const String baseUrl = "http://localhost:5000/api/giaodich";

class ApiService {
  // Lấy danh sách giao dịch
  Future<List<GiaoDich>> getAllGiaoDich() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => GiaoDich.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  // Thêm giao dịch
  Future<void> addGiaoDich(GiaoDich gd) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(gd.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add");
    }
  }

  // Cập nhật
  Future<void> updateGiaoDich(GiaoDich gd) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${gd.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(gd.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Update failed");
    }
  }

  // Xóa
  Future<void> deleteGiaoDich(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception("Delete failed");
    }
  }
}
