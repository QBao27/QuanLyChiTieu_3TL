class TaiKhoanDto {
  final String hoTen;
  final String email;
  final String? phone;
  final String matKhau;

  TaiKhoanDto({
    required this.hoTen,
    required this.email,
    this.phone,
    required this.matKhau,
  });

  Map<String, dynamic> toJson() {
    return {
      'hoTen': hoTen,
      'email': email,
      'phone': phone,
      'matKhau': matKhau,
    };
  }
}
