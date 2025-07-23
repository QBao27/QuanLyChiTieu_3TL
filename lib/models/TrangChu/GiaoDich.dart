// 1. Model cho phần summary
class Summary {
  final double totalIncome;
  final double totalExpense;
  final double balance;

  Summary({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpense: (json['totalExpense'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
    );
  }
}


// 2. Model cho mỗi giao dịch nhỏ (item)
class TransactionItem {
  final int id;
  final double soTien;
  final String loai;        // "Thu" hoặc "Chi"
  final String? moTa;
  final String icon;
  final String color;
  final String tenDanhMuc;

  TransactionItem({
    required this.id,
    required this.soTien,
    required this.loai,
    required this.moTa,
    required this.icon,
    required this.color,
    required this.tenDanhMuc,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'] as int,
      soTien: (json['soTien'] as num).toDouble(),
      loai: json['loai'] as String,
      moTa: json['moTa'] as String?,
      icon: json['icon'] as String,
      color: json['color'] as String,
      tenDanhMuc: json['tenDanhMuc'] as String,
    );
  }
}


// 3. Model cho nhóm giao dịch của một ngày
class DailyTransactions {
  final String date;    // "yyyy-MM-dd"
  final String weekday; // "Thứ Hai", "Chủ Nhật"
  final List<TransactionItem> items;

  DailyTransactions({
    required this.date,
    required this.weekday,
    required this.items,
  });

  factory DailyTransactions.fromJson(Map<String, dynamic> json) {
    return DailyTransactions(
      date: json['date'] as String,
      weekday: json['weekday'] as String,
      items: (json['items'] as List)
          .map((e) => TransactionItem.fromJson(e))
          .toList(),
    );
  }
}


// 4. Model tổng hợp cả report tháng
class MonthlyReport {
  final Summary summary;
  final List<DailyTransactions> transactions;

  MonthlyReport({
    required this.summary,
    required this.transactions,
  });

  factory MonthlyReport.fromJson(Map<String, dynamic> json) {
    return MonthlyReport(
      summary: Summary.fromJson(json['summary']),
      transactions: (json['transactions'] as List)
          .map((e) => DailyTransactions.fromJson(e))
          .toList(),
    );
  }
}
