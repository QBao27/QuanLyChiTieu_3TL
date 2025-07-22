// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class PieChartWidget extends StatelessWidget {
//   final List<Map<String, dynamic>> selectedData;
//   final int totalAmount;
//
//   const PieChartWidget({
//     super.key,
//     required this.selectedData,
//     required this.totalAmount,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         PieChart(
//           PieChartData(
//             sections: selectedData
//                 .map(
//                   (e) => PieChartSectionData(
//                 color: e['color'],
//                 value: e['amount'].toDouble(),
//                 title: '',
//                 radius: 60,
//               ),
//             )
//                 .toList(),
//             sectionsSpace: 2,
//             centerSpaceRadius: 55,
//           ),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '+${(totalAmount / 1000000).toStringAsFixed(2)} triệu',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/ThongKe/ThongKe_Models.dart';

class PieChartWidget extends StatelessWidget {
  final List<GiaoDich> giaoDiches;
  final double totalAmount;

  const PieChartWidget({
    super.key,
    required this.giaoDiches,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final groupedData = _groupByCategory();

    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sections: groupedData.map((cat) {
              return PieChartSectionData(
                color: _parseColor(cat['color']),
                value: cat['tong'],
                title: '', // Giống ThongKe: KHÔNG hiển thị %
                radius: 60,
              );
            }).toList(),
            sectionsSpace: 2,         // Giống ThongKe
            centerSpaceRadius: 55,    // Giống ThongKe
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '+${(totalAmount / 1000000).toStringAsFixed(2)} triệu',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }

  /// Nếu color là hex String thì parse
  /// Nếu bạn chắc nó luôn là hex, để String
  Color _parseColor(String? hex) {
    if (hex == null) return const Color(0xff2196f3);
    if (hex.startsWith('#')) {
      return Color(int.parse(hex.replaceFirst('#', '0xff')));
    } else if (hex.startsWith('0xff')) {
      return Color(int.parse(hex));
    } else {
      return Color(int.parse('0xff$hex'));
    }
  }

  /// Gom nhóm giao dịch theo idDanhMuc
  List<Map<String, dynamic>> _groupByCategory() {
    final Map<int, Map<String, dynamic>> result = {};
    for (var gd in giaoDiches) {
      result.putIfAbsent(gd.idDanhMuc, () {
        return {
          'tong': 0.0,
          'color': gd.color, // Coi chừng phải đúng kiểu hex
          'tenDanhMuc': gd.tenDanhMuc ?? '',
        };
      });
      result[gd.idDanhMuc]!['tong'] += gd.soTien;
    }
    return result.values.toList();
  }
}


