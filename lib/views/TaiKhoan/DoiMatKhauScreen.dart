// import 'package:flutter/material.dart';
//
// import '../../../services/local_storage_service.dart';
// import '../../../models/TaiKhoan/TaiKhoan.dart';
// import '../../controllers/TaiKhoan/API_DangNhap.dart';
//
// class DoiMatKhauScreen extends StatefulWidget {
//   const DoiMatKhauScreen({super.key});
//
//   @override
//   State<DoiMatKhauScreen> createState() => _DoiMatKhauScreenState();
// }
//
// class _DoiMatKhauScreenState extends State<DoiMatKhauScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _oldPassController = TextEditingController();
//   final TextEditingController _newPassController = TextEditingController();
//   final TextEditingController _confirmPassController = TextEditingController();
//
//   bool _isLoading = false;
//   User? _user;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }
//
//   void _loadUser() async {
//     final user = await LocalStorageService.getUser();
//     if (mounted) {
//       setState(() {
//         _user = user;
//       });
//     }
//   }
//
//   Future<void> _changePassword() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//
//       // In ra dữ liệu nhập vào
//       print('🔑 Mật khẩu cũ nhập vào: ${_oldPassController.text.trim()}');
//       print('🧠 Mật khẩu hiện tại của user: ${_user!.matKhau}');
//       print('🆕 Mật khẩu mới: ${_newPassController.text.trim()}');
//
//       // Kiểm tra mật khẩu cũ
//       if (_user!.matKhau != _oldPassController.text.trim()) {
//         _showSnackBar("Mật khẩu cũ không đúng", isError: true);
//         setState(() => _isLoading = false);
//         return;
//       }
//
//       // Gửi yêu cầu đổi mật khẩu
//       final success = await ApiService.changePassword(
//         _user!.id!,
//         _newPassController.text.trim(),
//       );
//
//       // In kết quả phản hồi
//       print('📡 Gửi đổi mật khẩu => Kết quả: $success');
//
//       setState(() => _isLoading = false);
//
//       if (success) {
//         _showSnackBar("Đổi mật khẩu thành công");
//         Navigator.pop(context);
//       } else {
//         _showSnackBar("Đổi mật khẩu thất bại", isError: true);
//       }
//     }
//   }
//
//
//   void _showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Đổi mật khẩu")),
//       body: _user == null
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _oldPassController,
//                 obscureText: true,
//                 decoration: const InputDecoration(labelText: "Mật khẩu cũ"),
//                 validator: (value) =>
//                 value!.isEmpty ? "Vui lòng nhập mật khẩu cũ" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _newPassController,
//                 obscureText: true,
//                 decoration: const InputDecoration(labelText: "Mật khẩu mới"),
//                 validator: (value) => value!.length < 6
//                     ? "Mật khẩu phải có ít nhất 6 ký tự"
//                     : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _confirmPassController,
//                 obscureText: true,
//                 decoration:
//                 const InputDecoration(labelText: "Xác nhận mật khẩu mới"),
//                 validator: (value) =>
//                 value != _newPassController.text
//                     ? "Mật khẩu không khớp"
//                     : null,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _changePassword,
//                 child: _isLoading
//                     ? const CircularProgressIndicator()
//                     : const Text("Đổi mật khẩu"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
