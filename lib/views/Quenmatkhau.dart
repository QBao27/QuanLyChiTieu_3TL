import 'package:flutter/material.dart';
import 'DangNhap.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendResetEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _emailSent = true;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email đặt lại mật khẩu đã được gửi!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _handleResendEmail() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email đã được gửi lại!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () => Navigator.of(context).pop(),
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
                      child: Icon(
                        _emailSent ? Icons.mark_email_read : Icons.lock_reset,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _emailSent ? 'Email đã được gửi!' : 'Quên mật khẩu?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _emailSent
                          ? 'Vui lòng kiểm tra email để đặt lại mật khẩu'
                          : 'Nhập email để nhận liên kết đặt lại mật khẩu',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Form Section
              if (!_emailSent) ...[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email hoặc số điện thoại',
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
                              borderSide: const BorderSide(color: Colors.redAccent,width:2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập email hoặc số điện thoại';
                            }
                            return null;
                          },
                        ),

                      ),

                      const SizedBox(height: 32),

                      // Send Reset Email Button
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
                          onPressed: _isLoading ? null : _handleSendResetEmail,
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
                            'Đặt lại',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Email Sent Section
              if (_emailSent) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Email đặt lại mật khẩu đã được gửi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chúng tôi đã gửi liên kết đặt lại mật khẩu đến:\n${_emailController.text}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Resend Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleResendEmail,
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
                        color: Colors.amber,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Gửi lại email',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Back to Login Button
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
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Quay lại đăng nhập',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 48),



              const SizedBox(height: 32),

              // Back to Login Link
              if (!_emailSent) ...[
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Đăng nhập ngay',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              ],
            ],
          ),
        ),
      ),
    );
  }
}