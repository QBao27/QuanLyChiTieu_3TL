import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String type;          // "Chi tiêu" hoặc "Thu nhập"
  final int amount;           // số tiền ban đầu
  final DateTime date;        // ngày
  final IconData icon;        // icon giao dịch
  final String note;          // ghi chú

  DetailPage({
    Key? key,
    required this.title,
    required this.type,
    required this.amount,
    required this.date,
    required this.icon,
    String? note,
  })  : note = (note == null || note.trim().isEmpty) ? 'Không' : note,
        super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late int _currentAmount;
  late TextEditingController _noteController;
  final _formatterDate   = DateFormat('d MMM, y', 'vi_VN');
  final _formatterNumber = NumberFormat('#,##0', 'vi_VN');

  @override
  void initState() {
    super.initState();
    _currentAmount = widget.amount;
    _noteController = TextEditingController(text: widget.note == 'Không' ? '' : widget.note);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Widget _buildRow(String label, Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }

  void _openKeyboard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditAmountKeyboard(
        initialAmount: _currentAmount,
        initialNote: _noteController.text,
        onConfirm: (newAmount, newNote) {
          setState(() {
            _currentAmount = newAmount;
            _noteController.text = newNote;
          });
          // TODO: Lưu thay đổi vào database nếu cần
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayAmount = '${_currentAmount < 0 ? '-' : '+'}${_formatterNumber.format(_currentAmount.abs())}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        leading: BackButton(color: Colors.black),
        title: const Text('Chi tiết', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey[200],
                    child: Icon(widget.icon, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(widget.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Nội dung chi tiết
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow('Kiểu', Text(widget.type)),
                    const SizedBox(height: 15),
                    _buildRow('Số tiền', Text(
                      displayAmount,
                      style: TextStyle(
                        fontSize: 16,
                        color: _currentAmount < 0 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    const SizedBox(height: 15),
                    _buildRow('Ngày', Text(_formatterDate.format(widget.date))),
                    const SizedBox(height: 15),
                    _buildRow('Ghi chú', Text(_noteController.text.isEmpty ? 'Không' : _noteController.text)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: _openKeyboard,
                child: const Text('Sửa', style: TextStyle(fontSize: 16)),
              ),
            ),
            Container(width: 2, height: 48, color: Colors.grey[300]),
            Expanded(
              child: TextButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Xác nhận'),
                      content: const Text('Bạn có chắc chắn muốn xóa không?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Hủy')),
                        TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Xóa', style: TextStyle(color: Colors.red))),
                      ],
                    ),
                  );
                  if (confirm == true) Navigator.of(context).pop();
                },
                child: const Text('Xóa', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================
// Custom Keyboard Bottom Sheet
// =============================
class EditAmountKeyboard extends StatefulWidget {
  final int initialAmount;
  final String initialNote;
  final void Function(int newAmount, String newNote) onConfirm;

  const EditAmountKeyboard({
    Key? key,
    required this.initialAmount,
    required this.initialNote,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<EditAmountKeyboard> createState() => _EditAmountKeyboardState();
}

class _EditAmountKeyboardState extends State<EditAmountKeyboard> {
  String amount = '0';
  late TextEditingController _noteCtr;
  final currencyFormat = NumberFormat.decimalPattern('vi');

  @override
  void initState() {
    super.initState();
    amount = currencyFormat.format(widget.initialAmount).replaceAll(',', '.');
    _noteCtr = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _noteCtr.dispose();
    super.dispose();
  }

  void _append(String x) {
    String clean = amount.replaceAll('.', '');
    if (clean.length >= 9) return;
    clean = clean == '0' ? x : clean + x;
    setState(() {
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
            // --- Header: Hủy & Số tiền ---
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  for (var k in ['7','8','9','⌫','4','5','6','✓','1','2','3','0'])
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
        if (isBackspace) {
          _backspace();
        } else if (isCheck) {
          // Xác nhận: gọi callback và đóng sheet
          final newAmount = int.parse(amount.replaceAll('.', ''));
          widget.onConfirm(newAmount, _noteCtr.text.trim());
          Navigator.of(context).pop();
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
