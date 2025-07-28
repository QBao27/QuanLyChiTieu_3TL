// class User {
//   final int? id;
//   final String hoTen;
//   final String email;
//   final String? phone;
//   final String matKhau;
//
//   User({
//     this.id,
//     required this.hoTen,
//     required this.email,
//     this.phone,
//     required this.matKhau,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       if (id != null) 'id': id,
//       'hoTen': hoTen,
//       'email': email,
//       if (phone != null) 'phone': phone,
//       'matKhau': matKhau,
//     };
//   }
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int?,
//       hoTen: json['hoTen'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String?,
//       matKhau: json['matKhau'] as String? ?? '', // Nếu không cần parse, có thể bỏ dòng này
//     );
//   }
// }
// class User {
//   final int? id;
//   final String hoTen;
//   final String email;
//   final String? phone;
//   final String matKhau;
//
//   User({
//     this.id,
//     required this.hoTen,
//     required this.email,
//     this.phone,
//     required this.matKhau,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       if (id != null) 'id': id,
//       'hoTen': hoTen,
//       'email': email,
//       if (phone != null) 'phone': phone,
//       'matKhau': matKhau,
//     };
//   }
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int?,
//       hoTen: json['hoTen'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String?,
//       matKhau: json['matKhau'] as String? ?? '',
//     );
//   }
// }

// lib/models/TaiKhoan/TaiKhoan.dart

class User {
  final int? id;
  final String hoTen;
  final String email;
  final String? phone;
  String matKhau;

  User({
    this.id,
    required this.hoTen,
    required this.email,
    this.phone,
    required this.matKhau,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id:      json['id']    as int?,
      hoTen:   json['hoTen'] as String,
      email:   json['email'] as String,
      phone:   json['phone'] as String?,
      matKhau: json['matKhau'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id    != null) 'id':      id,
      'hoTen':   hoTen,
      'email':   email,
      if (phone != null) 'phone':   phone,
      'matKhau': matKhau,
    };
  }
}
