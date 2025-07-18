class GiaoDich {
  int? id;
  double soTien;
  String loaiGiaoDich;
  String ngayGiaoDich;
  String moTa;
  int idDanhMuc;
  int idTaiKhoan;

  GiaoDich({
    this.id,
    required this.soTien,
    required this.loaiGiaoDich,
    required this.ngayGiaoDich,
    required this.moTa,
    required this.idDanhMuc,
    required this.idTaiKhoan,
  });

  factory GiaoDich.fromJson(Map<String, dynamic> json) {
    return GiaoDich(
      id: json['id'],
      soTien: json['soTien'],
      loaiGiaoDich: json['loaiGiaoDich'],
      ngayGiaoDich: json['ngayGiaoDich'],
      moTa: json['moTa'],
      idDanhMuc: json['idDanhMuc'],
      idTaiKhoan: json['idTaiKhoan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'soTien': soTien,
      'loaiGiaoDich': loaiGiaoDich,
      'ngayGiaoDich': ngayGiaoDich,
      'moTa': moTa,
      'idDanhMuc': idDanhMuc,
      'idTaiKhoan': idTaiKhoan,
    };
  }
}
