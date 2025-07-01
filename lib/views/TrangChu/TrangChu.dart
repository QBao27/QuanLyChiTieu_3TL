import 'package:flutter/material.dart';
import 'Trang_ChiTieu.dart';
import 'Trang_ThuNhap.dart';

class TrangChu extends StatefulWidget {
  const TrangChu({super.key});

  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  int selectedIndex = 0;

  // Danh sách các giao diện tương ứng
  final List<Widget> pages = [
    Center(child: Text("Giao diện Danh sách", style: TextStyle(fontSize: 24))),
    const ThemThuNhap(),
    const ThemChiTieu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quản Lý Chi Tiêu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: Column(
        children: [
          // Hàng nút lựa chọn
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow[700]
            ),
            padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
            child: Row(
              children: [
                // Nút 0: Danh sách
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() => selectedIndex = 0),
                    icon: Icon(
                      Icons.list,
                      color: selectedIndex == 0
                          ? Colors.yellow[700]
                          : Colors.black,
                    ),
                    label: Text(
                      "Danh sách",
                      style: TextStyle(
                        color: selectedIndex == 0
                            ? Colors.yellow[700]
                            : Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedIndex == 0
                          ? Colors.black
                          : Colors.yellow[700],
                      side: const BorderSide(color: Colors.black, width: 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),

                // Nút 1: Thu nhập
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() => selectedIndex = 1),
                    icon: Icon(
                      Icons.add,
                      color: selectedIndex == 1
                          ? Colors.yellow[700]
                          : Colors.black,
                    ),
                    label: Text(
                      "Thu nhập",
                      style: TextStyle(
                        color: selectedIndex == 1
                            ? Colors.yellow[700]
                            : Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedIndex == 1
                          ? Colors.black
                          : Colors.yellow[700],
                      side: const BorderSide(color: Colors.black, width: 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),

                // Nút 2: Chi tiêu
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() => selectedIndex = 2),
                    icon: Icon(
                      Icons.remove,
                      color: selectedIndex == 2
                          ? Colors.yellow[700]
                          : Colors.black,
                    ),
                    label: Text(
                      "Chi tiêu",
                      style: TextStyle(
                        color: selectedIndex == 2
                            ? Colors.yellow[700]
                            : Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedIndex == 2
                          ? Colors.black
                          : Colors.yellow[700],
                      side: const BorderSide(color: Colors.black, width: 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Nội dung bên dưới theo tab đã chọn
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: pages[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
