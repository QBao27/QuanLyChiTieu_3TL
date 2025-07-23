import 'package:appquanlychitieu/views/DangKy.dart' show SignUpScreen;
import 'package:appquanlychitieu/views/DangNhap.dart';
import 'package:appquanlychitieu/views/HoSo.dart';
import 'package:flutter/material.dart';
import 'views/TrangChu/TrangChu.dart';
import 'views/ThongKe/ThongKe.dart';
import 'views/Lich/Lich.dart';
import 'views/TaiKhoan/TaiKhoan.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // khởi tạo data format cho tất cả locales (nếu bạn muốn dùng nhiều locale)
  await initializeDateFormatting();
  // hoặc chỉ riêng vi: await initializeDateFormatting('vi', null);
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
      ),
      home: LoginScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    TrangChu(),
    ThongKe(),
    Lich(),
    TaiKhoanScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.yellow[700],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Thống kê'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Báo Cáo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
      ),
    );
  }
}