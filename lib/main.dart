import 'package:flutter/material.dart';
import 'views/TrangChu/TrangChu.dart';
import 'views/ThongKe/ThongKe.dart';
import 'views/Lich/Lich.dart';
import 'views/TaiKhoan/TaiKhoan.dart';
import 'views/DangNhap.dart';
import 'views/Quenmatkhau.dart';
import 'views/DangKy.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuanLyChiTieu_3TL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: SignUpScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    TrangChu(),
    ThongKe(),
    Lich(),
    Dangnhap()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Thống kê'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Lịch'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
      ),
    );
  }
}

