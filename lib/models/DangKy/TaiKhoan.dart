class TaiKhoan {
  final int id;
  final String hoTen;
  final String email;
  final String? phone;

  TaiKhoan({
    required this.id,
    required this.hoTen,
    required this.email,
    this.phone,
  });

  factory TaiKhoan.fromJson(Map<String, dynamic> json) {
    return TaiKhoan(
      id: json['id'],
      hoTen: json['hoTen'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}