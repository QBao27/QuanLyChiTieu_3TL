import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appquanlychitieu/utils/icon_helper.dart';
import 'package:appquanlychitieu/utils/category_colors.dart';
import 'package:appquanlychitieu/models/TrangChu/GiaoDich.dart';
import 'package:appquanlychitieu/controllers/TrangChu/API_GiaoDich.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemChiTieu extends StatefulWidget {
  const ThemChiTieu({super.key});

  @override
  State<ThemChiTieu> createState() => _ThemChiTieuState();
}

class _ThemChiTieuState extends State<ThemChiTieu> {
  int selectedIndex = -1;

  // 1. Icon, label và id danh mục
  final iconList = [
    Icons.shopping_cart_outlined, Icons.restaurant_outlined,
    Icons.phone_android_outlined, Icons.headset_mic_rounded,
    Icons.book_online, Icons.brush_outlined,
    Icons.directions_bike_outlined, Icons.people_alt_outlined,
    Icons.directions_bus_outlined, Icons.checkroom_rounded,
    Icons.directions_car_filled_outlined, Icons.liquor_outlined,
    Icons.all_inbox_outlined, Icons.computer_outlined,
    Icons.flight_outlined, Icons.health_and_safety_outlined,
    Icons.pets_outlined, Icons.build_outlined,
    Icons.home_outlined, Icons.card_giftcard_outlined,
    Icons.favorite_border_outlined, Icons.confirmation_num_outlined,
    Icons.fastfood_outlined, Icons.child_care_outlined,
    Icons.eco_outlined, Icons.local_florist_outlined,
    Icons.receipt_outlined, Icons.more_horiz_outlined,
  ];
  final labelList = [
    'Mua sắm','Đồ ăn','Điện thoại','Giải trí','Giáo dục','Sắc đẹp',
    'Thể thao','Xã hội','Vận tải','Quần áo','Xe hơi','Rượu bia',
    'Thuốc lá','Thiết bị','Du lịch','Sức khỏe','Thú cưng','Sửa chữa',
    'Nhà ở','Quà tặng','Quyên góp','Vé số','Đồ ăn nhẹ','Trẻ em',
    'Rau củ','Hoa quả','Hóa đơn','Khác',
  ];
  // Giờ chạy từ 5 → 32
  final idDanhMucList = List.generate(28, (i) => i + 5);

  Future<void> _onIconPressed(int idx) async {
    setState(() => selectedIndex = idx);

    // Lấy userId từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 1;

    final hex = titleColors[labelList[idx]] ?? '#9E9E9E';

    // Hiển thị bottom sheet
    final added = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CustomKeyboardSheet(
        idTaiKhoan: userId,
        idDanhMuc: idDanhMucList[idx],
        colorHex: hex,
      ),
    );

    // Nếu có thay đổi → gọi reload dữ liệu
    if (added == true) {
      // TODO: Gọi lại loadData hoặc cập nhật UI nếu cần
      // await _loadData();
    }

    setState(() => selectedIndex = -1);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(7, (row) {
            final start = row * 4;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: List.generate(4, (col) {
                  final idx = start + col;
                  return idx < iconList.length
                      ? buildIconButton(idx, iconList[idx], labelList[idx])
                      : const Expanded(child: SizedBox());
                }),
              ),
            );
          }),
        ),
      ),
    );
  }

  Expanded buildIconButton(int index, IconData icon, String label) {
    final hex = titleColors[label] ?? '#9E9E9E';
    final color = hexToColor(hex);
    return Expanded(
      child: Column(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: selectedIndex == index
                  ? Colors.yellow[700]
                  : color.withOpacity(0.2),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
            ),
            icon: Icon(icon, color: color),
            onPressed: () => _onIconPressed(index),
          ),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/// =============================
/// Custom Keyboard Bottom Sheet
/// =============================
class _CustomKeyboardSheet extends StatefulWidget {
  final int idTaiKhoan;
  final int idDanhMuc;
  final String colorHex;

  const _CustomKeyboardSheet({
    Key? key,
    required this.idTaiKhoan,
    required this.idDanhMuc,
    required this.colorHex,
  }) : super(key: key);

  @override
  State<_CustomKeyboardSheet> createState() => _CustomKeyboardSheetState();
}

class _CustomKeyboardSheetState extends State<_CustomKeyboardSheet> {
  String amount = '0';
  final _noteCtr = TextEditingController();
  final currencyFormat = NumberFormat.decimalPattern('vi');

  void _append(String x) {
    String clean = amount.replaceAll('.', '');
    if (clean.length >= 10) return;
    setState(() {
      clean = clean == '0' ? x : clean + x;
      amount = currencyFormat
          .format(int.parse(clean))
          .replaceAll(',', '.');
    });
  }

  void _backspace() {
    String clean = amount.replaceAll('.', '');
    if (clean.length <= 1) {
      setState(() => amount = '0');
      return;
    }
    clean = clean.substring(0, clean.length - 1);
    setState(() {
      amount = currencyFormat
          .format(int.parse(clean))
          .replaceAll(',', '.');
    });
  }

  Future<void> _submitGiaoDich() async {
    final soTien = double.parse(amount.replaceAll('.', ''));
    if (soTien <= 0) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Vui lòng nhập giá!')),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    final dateOnly = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final moTa = _noteCtr.text.trim().isEmpty
        ? null
        : _noteCtr.text.trim();
    final dto = ThemGiaoDichDto(
      loaiGiaoDich: 'chi',
      soTien: soTien,
      ngayGiaoDich: dateOnly,
      moTa: moTa,
      idDanhMuc: widget.idDanhMuc,
      color: widget.colorHex,
    );

    try {
      await ApiService().addGiaoDich(widget.idTaiKhoan, dto);
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Thêm giao dịch thành công!')),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Thêm thất bại!')),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, ctrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Hủy'),
                ),
                const Spacer(),
                Text(
                  amount,
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _noteCtr,
              decoration: InputDecoration(
                hintText: 'Ghi chú: Nhập ghi chú...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                controller: ctrl,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: ['7','8','9','⌫','4','5','6','✓','1','2','3','0']
                    .map(_buildKey)
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKey(String label) {
    final isCheck = label == '✓';
    final isBackspace = label == '⌫';
    return ElevatedButton(
      onPressed: () {
        if (isBackspace) {
          _backspace();
        } else if (isCheck) {
          _submitGiaoDich(); // <-- Gọi API khi nhấn ✓
          FocusScope.of(context).unfocus();
        } else {
          _append(label);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isCheck ? Colors.yellow[700] : Colors.grey[200],
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 22),
        minimumSize: const Size(50, 50),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: isCheck
          ? const Icon(Icons.check, size: 32, color: Colors.black)
          : isBackspace
          ? const Icon(Icons.backspace, size: 28)
          : Text(label),
    );
  }
}
