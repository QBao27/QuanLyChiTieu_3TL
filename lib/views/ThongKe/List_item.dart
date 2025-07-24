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
      case 'shopping_cart_outlined':
        return Icons.shopping_cart_outlined;
      case 'restaurant_outlined':
        return Icons.restaurant_outlined;
      case 'phone_android_outlined':
        return Icons.phone_android_outlined;
      case 'headset_mic_rounded':
        return Icons.headset_mic_rounded;
      case 'book_online':
        return Icons.book_online;
      case 'brush_outlined':
        return Icons.brush_outlined;
      case 'directions_bike_outlined':
        return Icons.directions_bike_outlined;
      case 'people_alt_outlined':
        return Icons.people_alt_outlined;
      case 'directions_bus_outlined':
        return Icons.directions_bus_outlined;
      case 'checkroom_rounded':
        return Icons.checkroom_rounded;
      case 'directions_car_filled_outlined':
        return Icons.directions_car_filled_outlined;
      case 'liquor_outlined':
        return Icons.liquor_outlined;
      case 'all_inbox_outlined':
        return Icons.all_inbox_outlined;
      case 'computer_outlined':
        return Icons.computer_outlined;
      case 'flight_outlined':
        return Icons.flight_outlined;
      case 'health_and_safety_outlined':
        return Icons.health_and_safety_outlined;
      case 'pets_outlined':
        return Icons.pets_outlined;
      case 'build_outlined':
        return Icons.build_outlined;
      case 'home_outlined':
        return Icons.home_outlined;
      case 'card_giftcard_outlined':
        return Icons.card_giftcard_outlined;
      case 'favorite_border_outlined':
        return Icons.favorite_border_outlined;
      case 'confirmation_num_outlined':
        return Icons.confirmation_num_outlined;
      case 'fastfood_outlined':
        return Icons.fastfood_outlined;
      case 'child_care_outlined':
        return Icons.child_care_outlined;
      case 'eco_outlined':
        return Icons.eco_outlined;
      case 'local_florist_outlined':
        return Icons.local_florist_outlined;
      case 'receipt_outlined':
        return Icons.receipt_outlined;
      case 'more_horiz_outlined':
        return Icons.more_horiz_outlined;
      case 'attach_money':
        return Icons.attach_money;
      case 'trending_up_outlined':
        return Icons.trending_up_outlined;
      case 'money_outlined':
        return Icons.money_outlined;
      case 'work_history_outlined':
        return Icons.work_history_outlined;
      default:
        return Icons.help_outline; // hoặc Icons.category nếu bạn thích
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




