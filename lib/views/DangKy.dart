// import 'package:flutter/material.dart';
// import 'DangNhap.dart';
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool _acceptTerms = false;
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _handleSignUp() async {
//     if (_formKey.currentState!.validate() && _acceptTerms) {
//       setState(() {
//         _isLoading = true;
//       });
//
//       // Simulate API call
//       await Future.delayed(const Duration(seconds: 2));
//
//       setState(() {
//         _isLoading = false;
//       });
//
//       // Handle sign up success/failure here
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Đăng ký thành công!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else if (!_acceptTerms) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Vui lòng đồng ý với điều khoản sử dụng'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//
//               // Header Section
//               Center(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Colors.amber, Colors.yellow],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.amber.withOpacity(0.3),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.person_add,
//                         size: 40,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Tạo tài khoản mới',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       'Điền thông tin để tạo tài khoản',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 40),
//
//               // Sign Up Form
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // Name Field
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: TextFormField(
//                         controller: _nameController,
//                         style: const TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           hintText: 'Họ và tên',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           prefixIcon: const Icon(Icons.person_outline, color: Colors.amber),
//                           contentPadding: const EdgeInsets.all(20),
//                           filled: true,
//                           fillColor: Colors.grey[900],
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[800]!),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.amber),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           errorStyle: const TextStyle(
//                             color: Colors.redAccent,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Vui lòng nhập họ và tên';
//                           }
//                           if (value.length < 2) {
//                             return 'Họ và tên phải có ít nhất 2 ký tự';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     // Email Field
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: TextFormField(
//                         controller: _emailController,
//                         style: const TextStyle(color: Colors.white),
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           hintText: 'Email',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           prefixIcon: const Icon(Icons.email_outlined, color: Colors.amber),
//                           contentPadding: const EdgeInsets.all(20),
//                           filled: true,
//                           fillColor: Colors.grey[900],
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[800]!),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.amber),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           errorStyle: const TextStyle(
//                             color: Colors.redAccent,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Vui lòng nhập email';
//                           }
//                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                             return 'Email không hợp lệ';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     // Phone Field
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: TextFormField(
//                         controller: _phoneController,
//                         style: const TextStyle(color: Colors.white),
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           hintText: 'Số điện thoại',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           prefixIcon: const Icon(Icons.phone_outlined, color: Colors.amber),
//                           contentPadding: const EdgeInsets.all(20),
//                           filled: true,
//                           fillColor: Colors.grey[900],
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[800]!),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.amber),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           errorStyle: const TextStyle(
//                             color: Colors.redAccent,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Vui lòng nhập số điện thoại';
//                           }
//                           if (value.length < 10) {
//                             return 'Số điện thoại phải có ít nhất 10 số';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     // Password Field
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: TextFormField(
//                         controller: _passwordController,
//                         obscureText: !_isPasswordVisible,
//                         style: const TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           hintText: 'Mật khẩu',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           prefixIcon: const Icon(Icons.lock_outline, color: Colors.amber),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                               color: Colors.amber,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                           contentPadding: const EdgeInsets.all(20),
//                           filled: true,
//                           fillColor: Colors.grey[900],
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[800]!),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.amber),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           errorStyle: const TextStyle(
//                             color: Colors.redAccent,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Vui lòng nhập mật khẩu';
//                           }
//                           if (value.length < 6) {
//                             return 'Mật khẩu phải có ít nhất 6 ký tự';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     // Confirm Password Field
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: TextFormField(
//                         controller: _confirmPasswordController,
//                         obscureText: !_isConfirmPasswordVisible,
//                         style: const TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           hintText: 'Xác nhận mật khẩu',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           prefixIcon: const Icon(Icons.lock_outline, color: Colors.amber),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                               color: Colors.amber,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                               });
//                             },
//                           ),
//                           contentPadding: const EdgeInsets.all(20),
//                           filled: true,
//                           fillColor: Colors.grey[900],
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[800]!),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.amber),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           errorStyle: const TextStyle(
//                             color: Colors.redAccent,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.redAccent),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Vui lòng xác nhận mật khẩu';
//                           }
//                           if (value != _passwordController.text) {
//                             return 'Mật khẩu không khớp';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     // Terms & Conditions
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: _acceptTerms,
//                           onChanged: (value) {
//                             setState(() {
//                               _acceptTerms = value ?? false;
//                             });
//                           },
//                           activeColor: Colors.amber,
//                           checkColor: Colors.black,
//                         ),
//                         Expanded(
//                           child: RichText(
//                             text: const TextSpan(
//                               text: 'Tôi đồng ý với ',
//                               style: TextStyle(color: Colors.grey),
//                               children: [
//                                 TextSpan(
//                                   text: 'Điều khoản sử dụng',
//                                   style: TextStyle(
//                                     color: Colors.amber,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: ' và ',
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 TextSpan(
//                                   text: 'Chính sách bảo mật',
//                                   style: TextStyle(
//                                     color: Colors.amber,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 32),
//
//                     // Sign Up Button
//                     Container(
//                       width: double.infinity,
//                       height: 56,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Colors.amber, Colors.yellow],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.amber.withOpacity(0.3),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: ElevatedButton(
//                         onPressed: _isLoading ? null : _handleSignUp,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         child: _isLoading
//                             ? const SizedBox(
//                           width: 24,
//                           height: 24,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                             : const Text(
//                           'Đăng ký',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 32),
//
//                     // Divider
//                     Row(
//                       children: [
//                         Expanded(child: Divider(color: Colors.grey[800])),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Text(
//                             'Hoặc đăng ký với',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ),
//                         Expanded(child: Divider(color: Colors.grey[800])),
//                       ],
//                     ),
//
//                     const SizedBox(height: 24),
//
//                     // Social Sign Up Buttons
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _socialButton(
//                             'Google',
//                             Icons.g_mobiledata,
//                             Colors.red,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _socialButton(
//                             'Facebook',
//                             Icons.facebook,
//                             Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 32),
//
//                     // Login Link
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Đã có tài khoản? ',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             'Đăng nhập ngay',
//                             style: TextStyle(
//                               color: Colors.amber,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _socialButton(String text, IconData icon, Color color) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[800]!),
//       ),
//       child: TextButton(
//         onPressed: () {
//           // Handle social sign up
//         },
//         style: TextButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: color, size: 24),
//             const SizedBox(width: 8),
//             Text(
//               text,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../controllers/DangKy/DangKy_API.dart';
import '../models/DangKy/DangKy.dart';
import 'DangNhap.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    debugPrint("▶ Gọi _handleSignUp");

    if (_formKey.currentState!.validate() && _acceptTerms) {
      setState(() => _isLoading = true);

      final dto = TaiKhoanDto(
        hoTen: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        matKhau: _passwordController.text.trim(),
      );

      debugPrint("📤 Form nhập: ${dto.toJson()}");

      final error = await TaiKhoanApi.dangKy(dto);

      setState(() => _isLoading = false);

      if (error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Đăng ký thành công!'),
            backgroundColor: Colors.green,
          ),
        );

        // Chuyển sang trang đăng nhập
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("❌ $error"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❗ Vui lòng đồng ý với điều khoản sử dụng'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.amber, Colors.yellow],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_add,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Tạo tài khoản mới',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Điền thông tin để tạo tài khoản',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Sign Up Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Họ và tên',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.person_outline, color: Colors.amber),
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          fillColor: Colors.grey[900],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[800]!),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w500,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập họ và tên';
                          }
                          if (value.trim().length < 2) {
                            return 'Họ và tên phải có ít nhất 2 ký tự';
                          }
                          final regex = RegExp(r'^[a-zA-ZÀ-ỹ\s]+$');
                          if (!regex.hasMatch(value)) {
                            return 'Họ và tên không được chứa ký tự đặc biệt hoặc số';
                          }
                          return null;
                        },

                      ),
                    ),

                    const SizedBox(height: 16),

                    // Email Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.email_outlined, color: Colors.amber),
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          fillColor: Colors.grey[900],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[800]!),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w500,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Email không hợp lệ';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Phone Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Số điện thoại',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.phone_outlined, color: Colors.amber),
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          fillColor: Colors.grey[900],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[800]!),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w500,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          if (value.length < 10) {
                            return 'Số điện thoại phải có ít nhất 10 số';
                          }
                          if (value.contains(' ')) {
                            return 'Số điện thoại không được chứa khoảng trắng';
                          }
                          final regex = RegExp(r'^[0-9]+$');
                          if (!regex.hasMatch(value)) {
                            return 'Số điện thoại chỉ được chứa số';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.amber),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          fillColor: Colors.grey[900],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[800]!),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w500,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          if (value.length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          }
                          if (value.contains(' ')) {
                            return 'Mật khẩu không được chứa khoảng trắng';
                          }
                          return null;
                        },

                      ),
                    ),

                    const SizedBox(height: 16),

                    // Confirm Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Xác nhận mật khẩu',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.amber),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          fillColor: Colors.grey[900],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[800]!),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w500,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng xác nhận mật khẩu';
                          }
                          if (value.contains(' ')) {
                            return 'Mật khẩu không được chứa khoảng trắng';
                          }
                          if (value != _passwordController.text) {
                            return 'Mật khẩu không khớp';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Terms & Conditions
                    Row(
                      children: [
                        Checkbox(
                          value: _acceptTerms,
                          onChanged: (value) {
                            setState(() {
                              _acceptTerms = value ?? false;
                            });
                          },
                          activeColor: Colors.amber,
                          checkColor: Colors.black,
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Tôi đồng ý với ',
                              style: TextStyle(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: 'Điều khoản sử dụng',
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' và ',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextSpan(
                                  text: 'Chính sách bảo mật',
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Sign Up Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.amber, Colors.yellow],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[800])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Hoặc đăng ký với',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey[800])),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Social Sign Up Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _socialButton(
                            'Google',
                            Icons.g_mobiledata,
                            Colors.red,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _socialButton(
                            'Facebook',
                            Icons.facebook,
                            Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Đã có tài khoản? ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Đăng nhập ngay',
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String text, IconData icon, Color color) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: TextButton(
        onPressed: () {
          // Handle social sign up
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}