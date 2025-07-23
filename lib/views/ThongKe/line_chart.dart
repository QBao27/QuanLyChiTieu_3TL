// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
//
// class LineChartWidget extends StatelessWidget {
//   final String selectedMonth;
//   final String selectedYear;
//   final int Function(int, int) getDaysInMonth;
//
//   const LineChartWidget({
//     super.key,
//     required this.selectedMonth,
//     required this.selectedYear,
//     required this.getDaysInMonth,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final int selectedMonthNumber =
//     int.parse(selectedMonth.replaceAll(RegExp(r'[^0-9]'), ''));
//     final int selectedYearNumber =
//     int.parse(selectedYear.replaceAll(RegExp(r'[^0-9]'), ''));
//     final int daysInMonth = getDaysInMonth(selectedMonthNumber, selectedYearNumber);
//
//     final List<FlSpot> data = List.generate(daysInMonth, (index) {
//       double y = (index == 7) ? 91000000 : 500000;
//       return FlSpot(index.toDouble(), y);
//     });
//
//     final double tong = data.fold(0, (prev, e) => prev + e.y);
//     final double trungBinh = tong / data.length;
//
//     return Column(
//       children: [
//         Text(
//           'Tổng cộng: ${NumberFormat("#,##0", "vi_VN").format(tong.toInt())}',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         Text(
//           'Trung bình: ${NumberFormat("#,##0", "vi_VN").format(trungBinh.toInt())}',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//         AspectRatio(
//           aspectRatio: 1.8,
//           child: LineChart(
//             LineChartData(
//               minY: 0,
//               maxY: data.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.1,
//               minX: 0,
//               maxX: daysInMonth.toDouble() - 1,
//               gridData: FlGridData(show: true),
//               borderData: FlBorderData(show: true),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: data,
//                   isCurved: false,
//                   barWidth: 2,
//                   color: Colors.lightBlue,
//                   dotData: FlDotData(show: true),
//                   belowBarData: BarAreaData(show: false),
//                 ),
//               ],
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 60,
//                     interval: 30000000,
//                     getTitlesWidget: (value, _) => Text(
//                       NumberFormat.compactCurrency(
//                         decimalDigits: 0,
//                         symbol: '',
//                         locale: 'vi_VN',
//                       ).format(value),
//                       style: const TextStyle(fontSize: 10),
//                     ),
//                   ),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 7,
//                     getTitlesWidget: (value, _) {
//                       int day = value.toInt() + 1;
//                       if (value % 7 == 0 && day != 29) {
//                         return Text('$day');
//                       }
//                       if (day == daysInMonth && (day == 28 || day == 30 || day == 31)) {
//                         return Text('$day');
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                 ),
//                 topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/ThongKe/ThongKe_Models.dart';

class LineChartWidget extends StatelessWidget {
  final List<GiaoDich> giaoDiches;
  final String selectedMonth;
  final String selectedYear;
  final int Function(int, int) getDaysInMonth;

  const LineChartWidget({
    super.key,
    required this.giaoDiches,
    required this.selectedMonth,
    required this.selectedYear,
    required this.getDaysInMonth,
  });

  @override
  Widget build(BuildContext context) {
    final int month = int.parse(selectedMonth.replaceAll(RegExp(r'[^0-9]'), ''));
    final int year = int.parse(selectedYear.replaceAll(RegExp(r'[^0-9]'), ''));
    final int daysInMonth = getDaysInMonth(month, year);

    final dailyTotal = List.generate(daysInMonth, (_) => 0.0);
    for (var gd in giaoDiches) {
      final date = DateTime.parse(gd.ngayGiaoDich);
      if (date.month == month && date.year == year) {
        dailyTotal[date.day - 1] += gd.soTien;
      }
    }

    final spots = List.generate(
      daysInMonth,
          (i) => FlSpot(i.toDouble(), dailyTotal[i]),
    );

    final tong = dailyTotal.fold(0.0, (prev, e) => prev + e);
    final trungBinh = tong / (daysInMonth);

    final maxY = dailyTotal.reduce((a, b) => a > b ? a : b) * 1.1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tổng cộng: ${NumberFormat("#,##0", "vi_VN").format(tong.toInt())}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Trung bình: ${NumberFormat("#,##0", "vi_VN").format(trungBinh.toInt())}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.8,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: maxY == 0 ? 1 : maxY,
              minX: 0,
              maxX: daysInMonth.toDouble() - 1,
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  barWidth: 2,
                  color: Colors.lightBlue,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, bar, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Colors.blueAccent,
                        strokeWidth: 0,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
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
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 7,
                    getTitlesWidget: (value, _) {
                      final day = value.toInt() + 1;
                      if (day == 1 || day == 8 || day == 15 || day == 22 || day == daysInMonth) {
                        return Text('$day', style: const TextStyle(fontSize: 10));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

