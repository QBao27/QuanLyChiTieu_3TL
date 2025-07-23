// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
//
// class BarChartWidget extends StatelessWidget {
//   const BarChartWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<BarChartGroupData> barGroups = List.generate(12, (index) {
//       double y = (index == 6) ? 91000000 : 3000000;
//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             toY: y,
//             color: Colors.orange,
//             width: 16,
//             borderRadius: BorderRadius.circular(6),
//           )
//         ],
//       );
//     });
//
//     return AspectRatio(
//       aspectRatio: 1.8,
//       child: BarChart(
//         BarChartData(
//           barGroups: barGroups,
//           gridData: FlGridData(show: true),
//           borderData: FlBorderData(show: false),
//           titlesData: FlTitlesData(
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, _) => Text('T${value.toInt() + 1}'),
//               ),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 50,
//                 getTitlesWidget: (value, _) {
//                   return Text(
//                     NumberFormat.compactCurrency(symbol: '', locale: 'vi_VN').format(value),
//                     style: const TextStyle(fontSize: 10),
//                   );
//                 },
//               ),
//             ),
//             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/ThongKe/ThongKe_Models.dart';

class BarChartWidget extends StatelessWidget {
  final List<GiaoDich> giaoDiches;

  const BarChartWidget({super.key, required this.giaoDiches});

  int getDaysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    final monthlyTotal = List.generate(12, (_) => 0.0);
    for (var gd in giaoDiches) {
      final date = DateTime.parse(gd.ngayGiaoDich);
      monthlyTotal[date.month - 1] += gd.soTien;
    }

    final maxY = monthlyTotal.reduce((a, b) => a > b ? a : b) * 1.1;

    final barGroups = List.generate(12, (index) {
      return BarChartGroupData(
        x: index + 1,
        barRods: [
          BarChartRodData(
            toY: monthlyTotal[index],
            color: Colors.deepOrange,
            width: 16,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    });

    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          barGroups: barGroups,
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) {
                  final month = value.toInt();
                  if (month >= 1 && month <= 12) {
                    return Text(
                      'T$month',
                      style: const TextStyle(fontSize: 10),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, _) {
                  return Text(
                    NumberFormat.compactCurrency(
                      symbol: '',
                      locale: 'vi_VN',
                    ).format(value),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }
}


