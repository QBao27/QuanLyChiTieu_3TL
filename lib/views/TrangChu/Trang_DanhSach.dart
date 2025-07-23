import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:appquanlychitieu/models/TrangChu/GiaoDich.dart';
import 'package:appquanlychitieu/controllers/TrangChu/API_GiaoDich.dart';
import 'Trang_ChiTiet.dart';
import 'package:appquanlychitieu/utils/icon_helper.dart';
import 'package:appquanlychitieu/utils/category_colors.dart';

class DanhSach extends StatefulWidget {
  const DanhSach({Key? key}) : super(key: key);

  @override
  State<DanhSach> createState() => _DanhSachState();
}

class _DanhSachState extends State<DanhSach> {
  DateTime _selectedDate = DateTime.now();
  final ApiService _api = ApiService();

  Summary? _summary;
  List<DailyTransactions> _sections = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final report = await _api
          .getMonthlyReport(
        idTaiKhoan: 1,
        month: _selectedDate.month,
        year: _selectedDate.year,
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Kết nối quá lâu, vui lòng thử lại sau.');
        },
      );

      setState(() {
        _summary = report.summary;
        _sections = report.transactions;
        _loading = false;
      });
    } on Exception catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

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
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmtDate = DateFormat('d MMM', 'vi');
    final fmtWeekday = DateFormat.EEEE('vi');
    final fmtNumber = NumberFormat.decimalPattern('vi');

    return Scaffold(
      body: Column(
        children: [
          // Month picker
          GestureDetector(
            onTap: _pickMonthYear,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 8),
                  Text(
                    'Tháng ${_selectedDate.month} Năm ${_selectedDate.year}',
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          const Divider(height: 1),

          // Body
          if (_loading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_error != null)
            Expanded(
              child: Center(child: Text('Lỗi: $_error')),
            )
          else if (_sections.isEmpty)
              Expanded(
                child: Center(child: Text('Không có giao dịch.')),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _sections.length,
                  itemBuilder: (ctx, idx) {
                    final section = _sections[idx];
                    final date = DateTime.parse(section.date);
                    final items = section.items;

                    final sumChi = items
                        .where((e) => e.loai.toLowerCase() == 'chi')
                        .fold<double>(0, (s, e) => s + e.soTien);

                    final sumThu = items
                        .where((e) => e.loai.toLowerCase() == 'thu')
                        .fold<double>(0, (s, e) => s + e.soTien);

                    return Column(
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Text(fmtDate.format(date),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(fmtWeekday.format(date),
                                    style:
                                    const TextStyle(color: Colors.grey)),
                              ),
                              const Spacer(),
                              Text(
                                'Chi: ${fmtNumber.format(sumChi.abs())}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12, // giảm kích thước chữ
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Thu: ${fmtNumber.format(sumThu)}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12, // giảm kích thước chữ
                                ),
                              ),

                            ],
                          ),
                        ),
                        // Items
                        ...items.map((e) {
                          final colorHex = e.color?.isNotEmpty == true ? e.color! : '#9E9E9E';
                          final bgColor = hexToColor(colorHex).withOpacity(0.2);
                          final iconColor = hexToColor(colorHex);
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: bgColor,
                              child: Icon(
                                getIconData(e.icon),
                                color: iconColor,
                                size: 20,
                              ),
                            ),
                            title: Text(e.moTa ?? e.tenDanhMuc),
                            trailing: Text(
                              '${e.loai.toLowerCase() == "chi" ? '-' : '+'}${fmtNumber.format(e.soTien.abs())}',
                              style: TextStyle(
                                color: e.loai.toLowerCase() == "chi" ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailPage(
                                  title: e.tenDanhMuc,
                                  type: e.loai,
                                  amount: e.soTien.toInt(),
                                  date: date,
                                  icon: getIconData(e.icon),
                                  note: e.moTa,
                                  color: hexToColor(e.color ?? '#9E9E9E')
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),

          // Footer summary
          if (_summary != null)
            Container(
              color: Colors.yellow[700],
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryCol(
                      'Thu nhập', _summary!.totalIncome, fmtNumber),
                  _buildSummaryCol(
                      'Chi tiêu', _summary!.totalExpense, fmtNumber),
                  _buildSummaryCol('Số dư', _summary!.balance, fmtNumber),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryCol(
      String label, double value, NumberFormat fmt) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(fmt.format(value), style: const TextStyle(fontSize: 14)),
        ],
      );
}
