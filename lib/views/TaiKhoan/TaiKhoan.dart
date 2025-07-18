import 'package:flutter/material.dart';

class TaiKhoanScreen extends StatefulWidget {
  const TaiKhoanScreen({super.key});

  @override
  State<TaiKhoanScreen> createState() => _TaiKhoanScreenState();
}

class _TaiKhoanScreenState extends State<TaiKhoanScreen> {
  // Thông tin người dùng mẫu
  String userName = "Nguyễn Văn A";
  String userEmail = "nguyenvana@email.com";
  String? userAvatar; // null = sử dụng icon mặc định
  bool isLoggedIn = true; // Trạng thái đăng nhập

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => _showAvatarOptions(),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: userAvatar != null
                    ? NetworkImage(userAvatar!)
                    : null,
                child: userAvatar == null
                    ? const Icon(Icons.person, color: Colors.white, size: 20)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLoggedIn ? userName : "Đăng nhập",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    isLoggedIn ? userEmail : "Đăng nhập, thú vị hơn!",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.grey),
          Expanded(
            child: ListView(
              children: [
                if (isLoggedIn) ...[
                  menuItem("Xem hồ sơ", Icons.account_circle),
                  menuItem("Đổi mật khẩu", Icons.lock_outline),
                  menuItem("Đăng xuất", Icons.logout, isLogout: true),
                ] else ...[
                  menuItem("Đăng nhập", Icons.login),
                  menuItem("Quên mật khẩu", Icons.help_outline),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(String title, IconData icon, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.yellow,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontWeight: isLogout ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: () => _handleMenuTap(title),
    );
  }

  void _handleMenuTap(String title) {
    switch (title) {
      case "Xem hồ sơ":
        _showProfile();
        break;
      case "Đổi mật khẩu":
        _showChangePassword();
        break;
      case "Quên mật khẩu":
        _showForgotPassword();
        break;
      case "Đăng nhập":
        _showLogin();
        break;
      case "Đăng xuất":
        _showLogoutConfirmation();
        break;
      default:
        break;
    }
  }

  void _showAvatarOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Chọn ảnh đại diện',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.yellow),
                title: const Text('Chụp ảnh', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.yellow),
                title: const Text('Chọn từ thư viện', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery();
                },
              ),
              if (userAvatar != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Xóa ảnh', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    _removeAvatar();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _showProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Hồ sơ của tôi',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage: userAvatar != null
                      ? NetworkImage(userAvatar!)
                      : null,
                  child: userAvatar == null
                      ? const Icon(Icons.person, color: Colors.white, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tên: $userName',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: $userEmail',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Đóng',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _editProfile();
              },
              child: const Text(
                'Chỉnh sửa',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showChangePassword() {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Đổi mật khẩu',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu cũ',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu mới',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Xác nhận mật khẩu mới',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                if (newPasswordController.text == confirmPasswordController.text) {
                  Navigator.of(context).pop();
                  _changePassword(oldPasswordController.text, newPasswordController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mật khẩu xác nhận không khớp!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                'Đổi mật khẩu',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showForgotPassword() {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Quên mật khẩu',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Nhập email của bạn để nhận hướng dẫn đặt lại mật khẩu',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetPassword(emailController.text);
              },
              child: const Text(
                'Gửi',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogin() {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Đăng nhập',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _login(emailController.text, passwordController.text);
              },
              child: const Text(
                'Đăng nhập',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Xác nhận đăng xuất',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Bạn có chắc chắn muốn đăng xuất?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text(
                'Đăng xuất',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Các hàm xử lý chức năng
  void _takePhoto() {
    // TODO: Implement camera functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chụp ảnh - Chức năng sẽ được phát triển')),
    );
  }

  void _pickFromGallery() {
    // TODO: Implement gallery picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chọn từ thư viện - Chức năng sẽ được phát triển')),
    );
  }

  void _removeAvatar() {
    setState(() {
      userAvatar = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã xóa ảnh đại diện')),
    );
  }

  void _editProfile() {
    // TODO: Navigate to edit profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chỉnh sửa hồ sơ - Chức năng sẽ được phát triển')),
    );
  }

  void _changePassword(String oldPassword, String newPassword) {
    // TODO: Implement password change
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đổi mật khẩu thành công!')),
    );
  }

  void _resetPassword(String email) {
    // TODO: Implement password reset
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã gửi hướng dẫn đặt lại mật khẩu đến email của bạn')),
    );
  }

  void _login(String email, String password) {
    // TODO: Implement login logic
    setState(() {
      isLoggedIn = true;
      userName = "Nguyễn Văn A"; // Thay thế bằng dữ liệu thực
      userEmail = email;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đăng nhập thành công!')),
    );
  }

  void _logout() {
    setState(() {
      isLoggedIn = false;
      userName = "";
      userEmail = "";
      userAvatar = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã đăng xuất!')),
    );
  }
}