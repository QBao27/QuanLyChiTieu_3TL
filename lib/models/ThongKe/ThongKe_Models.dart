class GiaoDich {
  final int id;
  final double soTien; // dùng double để dễ tính toán
  final String loaiGiaoDich;
  final String ngayGiaoDich; // bạn có thể parse ra DateTime nếu thích
  final String? moTa;
  final int idDanhMuc;
  final int idTaiKhoan;
  final String? color; // màu hex từ API
  final String? tenDanhMuc;
  final String? icon;

  GiaoDich({
    required this.id,
    required this.soTien,
    required this.loaiGiaoDich,
    required this.ngayGiaoDich,
    this.moTa,
    required this.idDanhMuc,
    required this.idTaiKhoan,
    this.color,
    this.tenDanhMuc,
    this.icon,
  });

  factory GiaoDich.fromJson(Map<String, dynamic> json) {
    return GiaoDich(
      id: json['id'],
      soTien: json['soTien']?.toDouble() ?? 0,
      loaiGiaoDich: json['loaiGiaoDich'],
      ngayGiaoDich: json['ngayGiaoDich'],
      moTa: json['moTa'],
      idDanhMuc: json['idDanhMuc'],
      idTaiKhoan: json['idTaiKhoan'],
      color: json['color'],
      tenDanhMuc: json['tenDanhMuc'],
      icon: json['icon'],
    );
  }
}
