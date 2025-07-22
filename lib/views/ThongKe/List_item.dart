// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class ListTileItem extends StatelessWidget {
//   final List<Map<String, dynamic>> data;
//
//   const ListTileItem({
//     super.key,
//     required this.data,
//   });
//
//   String formatCurrency(int amount) {
//     final format = NumberFormat("#,##0", "vi_VN");
//     return format.format(amount);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           children: data.map((item) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 18,
//                     backgroundColor: item['color'].withOpacity(0.2),
//                     child: Icon(item['icon'], color: item['color'], size: 20),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               item['name'],
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w600),
//                             ),
//                             const Spacer(),
//                             Text('${item['percent'].toStringAsFixed(2)}%',
//                                 style: const TextStyle(fontWeight: FontWeight.w500)),
//                             const SizedBox(width: 10),
//                             Text(
//                               formatCurrency(item['amount']),
//                               style: const TextStyle(color: Colors.grey),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 6),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(5),
//                           child: LinearProgressIndicator(
//                             value: item['percent'] / 100,
//                             minHeight: 6,
//                             backgroundColor: Colors.grey[200],
//                             valueColor: AlwaysStoppedAnimation<Color>(item['color']),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../models/ThongKe/ThongKe_Models.dart';

class ListTileItem extends StatelessWidget {
  final List<GiaoDich> data;

  const ListTileItem({super.key, required this.data});

  IconData _mapIcon(String? icon) {
    switch (icon) {
      case 'savings':
        return Icons.savings;
      case 'attach_money':
        return Icons.attach_money;
      case 'business_center':
        return Icons.business_center;
      case 'flight':
        return Icons.flight;
      case 'book':
        return Icons.book;
      case 'devices':
        return Icons.devices;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    final double total = data.fold(0, (sum, e) => sum + e.soTien);

    final Map<String, List<GiaoDich>> grouped = {};
    for (var item in data) {
      if (item.tenDanhMuc == null) continue;
      grouped.putIfAbsent(item.tenDanhMuc!, () => []).add(item);
    }

    final List<_GroupItem> groups = grouped.entries.map((entry) {
      final list = entry.value;
      final double amount = list.fold(0.0, (sum, e) => sum + e.soTien);
      final double percent = total > 0 ? (amount / total) * 100 : 0.0;
      final first = list.first;
      return _GroupItem(
        name: entry.key,
        amount: amount,
        percent: percent,
        color: first.color ?? '#2196f3',
        icon: first.icon,
      );
    }).toList();

    groups.sort((a, b) => b.amount.compareTo(a.amount));

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final item = groups[index];
        final color = Color(
          int.tryParse(
            item.color.startsWith('#')
                ? item.color.replaceFirst('#', '0xff')
                : '0xff${item.color}',
          ) ??
              0xff2196f3,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(
                  _mapIcon(item.icon),
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${item.percent.toStringAsFixed(2)}%',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${item.amount.toStringAsFixed(0)} đ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: LinearProgressIndicator(
                        value: item.percent / 100,
                        minHeight: 6,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GroupItem {
  final String name;
  final double amount;
  final double percent;
  final String color;
  final String? icon;

  _GroupItem({
    required this.name,
    required this.amount,
    required this.percent,
    required this.color,
    this.icon,
  });
}




