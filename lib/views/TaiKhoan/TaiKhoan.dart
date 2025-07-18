import 'package:flutter/material.dart';

class Dangnhap extends StatefulWidget {
  const Dangnhap({super.key});

  @override
  State<Dangnhap> createState() => _DangnhapState();
}

class _DangnhapState extends State<Dangnhap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Đăng nhập",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Đăng nhập, thú vị hơn!",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
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
                menuItem("Xem hồ sơ", Icons.account_circle),
                menuItem("Quên mật khẩu", Icons.help_outline),
                menuItem("Đổi mật khẩu", Icons.lock_reset),
                menuItem("Đăng xuất", Icons.logout, isLogout: true),
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
          color: isLogout ? Colors.red : Colors.yellow
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontWeight: isLogout ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {
        if (isLogout) {
          // Hiển thị dialog xác nhận đăng xuất
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
                      // Xử lý đăng xuất ở đây
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
        } else {
          // Xử lý các menu item khác
          switch (title) {
            case "Xem hồ sơ":
            // Navigate to profile screen
              break;
            case "Quên mật khẩu":
            // Navigate to forgot password screen
              break;
            case "Đổi mật khẩu":
            // Navigate to change password screen
              break;
            default:
              break;
          }
        }
      },
    );
  }
}