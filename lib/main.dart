import 'package:appquanlychitieu/views/DangKy.dart' show SignUpScreen;
import 'package:appquanlychitieu/views/DangNhap.dart';
import 'package:appquanlychitieu/views/HoSo.dart';
import 'package:appquanlychitieu/views/TrangChu/TrangChu.dart';
import 'package:appquanlychitieu/views/ThongKe/thongke_screen.dart';
import 'package:appquanlychitieu/views/Lich/Lich.dart';
import 'package:appquanlychitieu/views/TaiKhoan/TaiKhoan.dart';
import 'package:appquanlychitieu/ID_TaiKhoan/user_preferences.dart';  // Import cái này!
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuanLyChiTieu_3TL',
      theme: ThemeData(),
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

  int? userId; // Biến để lưu ID lấy từ SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await UserPreferences.getUserId();
    setState(() {
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Nếu chưa có userId => chờ
    if (userId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pages = [
      const TrangChu(),
      ThongKeScreen(idTaiKhoan: userId!), // Truyền đúng ID đã lấy!
      const Lich(),
      const TaiKhoanScreen(),
    ];

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
