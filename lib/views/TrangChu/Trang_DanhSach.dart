import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'Trang_ChiTiet.dart';

class DanhSach extends StatefulWidget {
  const DanhSach({super.key});

  @override
  State<DanhSach> createState() => _DanhSachState();
}

class _DanhSachState extends State<DanhSach> {
  DateTime _selectedDate = DateTime.now();

  // Dữ liệu mẫu
  final List<Map<String, dynamic>> dummySections = [
    {
      'date': DateTime(2025, 6, 30),
      'items': [
        {
          'icon': Icons.restaurant,
          'title': 'Đồ ăn',
          'amount': -9,
          'note': 'Ăn trưa cùng bạn bè'
        },
        {
          'icon': Icons.category,
          'title': 'Khác',
          'amount': 10000000008,
          'note': null
        },
        {
          'icon': Icons.restaurant,
          'title': 'Đồ ăn',
          'amount': -3,
          'note': ''
        },
      ],
    },
    {
      'date': DateTime(2025, 7, 6),
      'items': [
        {
          'icon': Icons.payments,
          'title': 'Lương',
          'amount': 6000000000,
          'note': 'Lương tháng 6'
        },
        {
          'icon': Icons.shopping_cart,
          'title': 'Áo ngược',
          'amount': -12000000,
          'note': null
        },
        {
          'icon': Icons.shopping_cart,
          'title': 'Mua sắm',
          'amount': -1000000000,
          'note': 'Mua đồ dùng'
        },
      ],
    },
    {
      'date': DateTime(2025, 7, 6),
      'items': [
        {
          'icon': Icons.phone_iphone,
          'title': 'Điện thoại',
          'amount': -30000,
          'note': 'Mua ốp lưng'
        },
        {
          'icon': Icons.payments,
          'title': 'Lương',
          'amount': 5000000,
          'note': 'Lương tháng 6'
        },
        {
          'icon': Icons.shopping_cart,
          'title': 'Mua sắm',
          'amount': -20000,
          'note': 'Mua đồ dùng'
        },
      ],
    },
  ];

  Future<void> _pickMonthYear() async {
    final picked = await showMonthPicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('vi'),
      headerColor: Colors.yellow[700],
      headerTextColor: Colors.white,
      selectedMonthBackgroundColor: Colors.yellow[700],
      selectedMonthTextColor: Colors.white,
      unselectedMonthTextColor: Colors.black54,
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatterDate    = DateFormat('d MMM', 'vi');
    final formatterWeekday = DateFormat.EEEE('vi');
    final formatterNumber  = NumberFormat.decimalPattern('vi');

    return Scaffold(
      body: Column(
        children: [
          // Picker tháng năm
          GestureDetector(
            onTap: _pickMonthYear,
            child: Center(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200]),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    const SizedBox(width: 8),
                    Text(
                      'Tháng ${_selectedDate.month} Năm ${_selectedDate.year}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),

          const Divider(height: 1),

          // Danh sách nhóm theo ngày
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: dummySections.length,
              itemBuilder: (context, sectionIdx) {
                final section = dummySections[sectionIdx];
                final date    = section['date'] as DateTime;
                final items   = section['items'] as List<Map<String, dynamic>>;

                // Tính tổng
                final sumChi = items
                    .where((e) => e['amount'] < 0)
                    .fold<int>(0, (sum, e) => sum + e['amount'] as int);
                final sumThu = items
                    .where((e) => e['amount'] > 0)
                    .fold<int>(0, (sum, e) => sum + e['amount'] as int);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header ngày
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            formatterDate.format(date),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              formatterWeekday.format(date),
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          Flexible(
                            flex: 0,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '- ${formatterNumber.format(-sumChi)}',
                                  style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '+ ${formatterNumber.format(sumThu)}',
                                  style: const TextStyle(color: Colors.green, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Các item
                    ...items.map((e) {
                      final title  = e['title'] as String;
                      final amount = e['amount'] as int;
                      final icon   = e['icon'] as IconData;
                      final note   = e['note'] as String?;

                      final type = amount < 0 ? 'Chi tiêu' : 'Thu nhập';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Icon(icon, color: Colors.white, size: 20),
                        ),
                        title: Text(title),
                        trailing: Text(
                          '${amount < 0 ? '-' : '+'}${formatterNumber.format(amount.abs())}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: amount < 0 ? Colors.red : Colors.green,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(
                                title: title,
                                type: type,
                                amount: amount,
                                date: date,
                                icon: icon,
                                note: note,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),

                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      // Thanh tổng kết
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: Colors.yellow[700],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Thu nhập', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(formatterNumber.format(56313131), style: const TextStyle(fontSize: 14)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Chi tiêu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(formatterNumber.format(1000120000), style: const TextStyle(fontSize: 14)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Số dư', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  formatterNumber.format(56313131 - 1000120000),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
