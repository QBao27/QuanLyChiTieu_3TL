import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThemThuNhap extends StatefulWidget {
  const ThemThuNhap({super.key});

  @override
  State<ThemThuNhap> createState() => _ThemThuNhapState();
}

class _ThemThuNhapState extends State<ThemThuNhap> {
  int selectedIndex = -1;

  void _onIconPressed(int idx) {
    setState(() => selectedIndex = idx);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _CustomKeyboardSheet(),
    ).whenComplete(() {
      // Khi sheet đóng xong, reset selectedIndex
      setState(() {
        selectedIndex = -1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(7, (row) {
            final start = row * 4;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: List.generate(4, (col) {
                  final index = start + col;
                  final iconList = [
                    Icons.attach_money,
                    Icons.trending_up_outlined,
                    Icons.card_giftcard_outlined,
                    Icons.money_outlined,
                    Icons.work_history_outlined,
                    Icons.more_horiz_outlined,
                  ];
                  final labelList = [
                    'Lương',
                    'Đầu tư',
                    'Giải thưởng',
                    'Lì xì',
                    'Làm thêm',
                    'Khác',
                  ];
                  return index < iconList.length
                      ? buildIconButton(
                          index,
                          iconList[index],
                          labelList[index],
                        )
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
    return Expanded(
      child: Column(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: selectedIndex == index
                  ? Colors.yellow[700]
                  : Colors.grey[300],
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
            ),
            icon: Icon(icon),
            onPressed: () => _onIconPressed(index),
          ),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// =============================
// Custom Keyboard Bottom Sheet
// =============================
class _CustomKeyboardSheet extends StatefulWidget {
  const _CustomKeyboardSheet({Key? key}) : super(key: key);

  @override
  State<_CustomKeyboardSheet> createState() => _CustomKeyboardSheetState();
}

class _CustomKeyboardSheetState extends State<_CustomKeyboardSheet> {
  String amount = '0';
  final _noteCtr = TextEditingController();
  final currencyFormat = NumberFormat.decimalPattern(
    'vi',
  ); // Sử dụng định dạng VN

  void _append(String x) {
    String clean = amount.replaceAll('.', '');
    if (clean.length >= 10) return; // giới hạn 9 chữ số
    setState(() {
      clean = clean == '0' ? x : clean + x;
      amount = currencyFormat.format(int.parse(clean)).replaceAll(',', '.');
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
      amount = currencyFormat.format(int.parse(clean)).replaceAll(',', '.');
    });
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
            // --- Hiển thị số tiền ---
            // Thay vì 2 Align riêng, dùng Row:
            Row(
              children: [
                // Nút Hủy canh trái
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
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

                // Khoảng cách đẩy amount về bên phải
                const Spacer(),

                // Hiển thị số tiền canh phải
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // --- TextField Ghi chú ---
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

            // --- Bàn phím số ---
            Expanded(
              child: GridView.count(
                controller: ctrl,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  for (var k in [
                    '7',
                    '8',
                    '9',
                    '⌫',
                    '4',
                    '5',
                    '6',
                    '✓',
                    '1',
                    '2',
                    '3',
                    '0',
                  ])
                    _buildKey(k),
                ],
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
        switch (label) {
          case '⌫':
            _backspace();
            break;
          case '✓':
            Navigator.of(context).pop();
            break;
          default:
            if (RegExp(r"^\d$|'$").hasMatch(label)) _append(label);
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
