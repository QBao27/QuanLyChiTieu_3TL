import 'package:flutter/material.dart';

final Map<String, String> titleColors = {
  'Mua sắm': '#448AFF',
  'Đồ ăn': '#FFB74D',
  'Điện thoại': '#3F51B5',
  'Giải trí': '#9C27B0',
  'Giáo dục': '#FFC107',
  'Sắc đẹp': '#FF4081',
  'Thể thao': '#4CAF50',
  'Xã hội': '#009688',
  'Vận tải': '#795548',
  'Quần áo': '#FF5722',
  'Xe hơi': '#9E9E9E',
  'Rượu bia': '#F44336',
  'Thuốc lá': '#757575',
  'Thiết bị': '#03A9F4',
  'Du lịch': '#00BCD4',
  'Sức khỏe': '#69F0AE',
  'Thú cưng': '#7C4DFF',
  'Sửa chữa': '#CDDC39',
  'Nhà ở': '#607D8B',
  'Quà tặng': '#F44336',
  'Quyên góp': '#8BC34A',
  'Vé số': '#FF7043',
  'Đồ ăn nhẹ': '#FF9800',
  'Trẻ em': '#FFEB3B',
  'Rau củ': '#B2FF59',
  'Hoa quả': '#E91E63',
  'Hóa đơn': '#2196F3',
  'Khác': '#9E9E9E',
  'Lương': '#4CAF50',
  'Đầu tư': '#448AFF',
  'Giải thưởng': '#FFC107',
  'Lì xì': '#F44336',
  'Làm thêm': '#673AB7',
};

Color hexToColor(String hex) {
  if (!hex.startsWith('#')) hex = '#$hex';
  var cleaned = hex.replaceAll('#', '');
  if (cleaned.length != 6 && cleaned.length != 8) {
    throw FormatException('Mã màu không hợp lệ: $hex');
  }
  if (cleaned.length == 6) cleaned = 'FF$cleaned';
  return Color(int.parse(cleaned, radix: 16));
}
