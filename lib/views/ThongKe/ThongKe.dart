    import 'package:flutter/material.dart';
    import 'package:fl_chart/fl_chart.dart';
    import 'package:intl/intl.dart';
    import 'package:smooth_page_indicator/smooth_page_indicator.dart';

    class ThongKe extends StatefulWidget {
      const ThongKe({super.key});

      @override
      State<ThongKe> createState() => _ThongKeState();
    }

    class _ThongKeState extends State<ThongKe> {
      final GlobalKey _titleKey = GlobalKey();

      int getDaysInMonth(int month, int year) {
        return DateTime(year, month + 1, 0).day;
      }
      bool isMonthSelected = true;
      String selectedType = 'Chi tiêu';

      final List<String> types = ['Chi tiêu', 'Thu nhập'];

      static const aonguoc = Icons.flight;

      final List<String> monthOptions = [
        'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4',
        'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8',
        'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'
      ];
      String selectedMonth = 'Tháng ${DateTime.now().month}';

      late List<String> yearOptions;
      String selectedYear = 'Năm ${DateTime.now().year}';

      final List<Map<String, dynamic>> dataChiTieu = const  [
        {
          'name': 'Giáo dục',
          'amount': 8000000,
          'percent': 97.88,
          'color': Colors.indigo,
          'icon': Icons.book,
        },
        {
          'name': 'Du lịch 1',
          'amount': 90000,
          'percent': 1.10,
          'color': Colors.purple,
          'icon': aonguoc,
        },
        {
          'name': 'Thiết bị điện tử',
          'amount': 83055,
          'percent': 1.01,
          'color': Colors.deepOrange,
          'icon': Icons.devices,
        },
      ];

      final List<Map<String, dynamic>> dataThuNhap = const [
        {
          'name': 'Lương',
          'amount': 10000000,
          'percent': 80.0,
          'color': Colors.grey,
          'icon': Icons.attach_money,
        },
        {
          'name': 'Kinh doanh',
          'amount': 2000000,
          'percent': 16.0,
          'color': Colors.redAccent,
          'icon': Icons.business_center,
        },
        {
          'name': 'Lãi tiết kiệm',
          'amount': 500000,
          'percent': 4.0,
          'color': Colors.lightBlue,
          'icon': Icons.savings,
        },
        {
          'name': 'Lãi tiết kiệm',
          'amount': 500000,
          'percent': 4.0,
          'color': Colors.greenAccent,
          'icon': Icons.savings,
        },
        {
          'name': 'Kinh doanh',
          'amount': 2000000,
          'percent': 16.0,
          'color': Colors.lightGreen,
          'icon': Icons.business_center,
        },
        {
          'name': 'Lãi tiết kiệm',
          'amount': 500000,
          'percent': 4.0,
          'color': Colors.deepOrangeAccent,
          'icon': Icons.savings,
        },
        {
          'name': 'Lương',
          'amount': 10000000,
          'percent': 80.0,
          'color': Colors.lightGreenAccent,
          'icon': Icons.attach_money,
        },
      ];

      final List<FlSpot> lineChartData = [
        FlSpot(1, 2),
        FlSpot(2, 4),
        FlSpot(3, 1),
        FlSpot(4, 3),
        FlSpot(5, 2.5),
        FlSpot(6, 4.5),
      ];

      final PageController _pageController = PageController();

      @override
      void initState() {
        super.initState();
        final now = DateTime.now();
        yearOptions = [
          for (int year = 2020; year <= now.year; year++) 'Năm $year'
        ];
      }

      List<Map<String, dynamic>> get selectedData =>
          selectedType == 'Chi tiêu' ? dataChiTieu : dataThuNhap;

      String formatCurrency(int amount) {
        final format = NumberFormat("#,##0", "vi_VN");
        return format.format(amount);
      }

      Widget buildTabList({
        required List<String> options,
        required String selectedValue,
        required Function(String) onTap,
      }) {
        return SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final label = options[index];
              final isSelected = label == selectedValue;
              return GestureDetector(
                onTap: () => onTap(label),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.black : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (isSelected)
                        Container(
                          height: 2,
                          width: 40,
                          color: Colors.yellow[700],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }

      Widget buildLineChart() {
        // Lấy tháng và năm từ chuỗi như "Tháng 7" và "Năm 2025"
        final int selectedMonthNumber =
        int.parse(selectedMonth.replaceAll(RegExp(r'[^0-9]'), ''));
        final int selectedYearNumber =
        int.parse(selectedYear.replaceAll(RegExp(r'[^0-9]'), ''));

        final int daysInMonth = getDaysInMonth(selectedMonthNumber, selectedYearNumber);

        final List<FlSpot> data = List.generate(daysInMonth, (index) {
          // Tạo dữ liệu giả: Ngày 8 có giá trị cao bất thường
          double y = (index == 7) ? 91000000 : 500000;
          return FlSpot(index.toDouble(), y);
        });

        final List<Color> dotColors = List.generate(
          data.length,
              (index) => Colors.primaries[index % Colors.primaries.length],
        );

        final double tong = data.fold(0, (prev, e) => prev + e.y);
        final double trungBinh = tong / data.length;

        return Column(
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
                  maxY: data.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.1,
                  minX: 0,
                  maxX: daysInMonth.toDouble() - 1,
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data,
                      isCurved: false,
                      barWidth: 2,
                      color: Colors.lightBlue,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: dotColors[index],
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
                        reservedSize: 60,
                        interval: 30000000,
                        getTitlesWidget: (value, _) => Text(
                          NumberFormat.compactCurrency(
                            decimalDigits: 0,
                            symbol: '',
                            locale: 'vi_VN',
                          ).format(value),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 7,
                        getTitlesWidget: (value, _) {
                          int day = value.toInt() + 1;

                          // Hiển thị nếu chia hết cho 7 và không phải ngày 29
                          if (value % 7 == 0 && day != 29) {
                            return Text('$day');
                          }

                          // Hiển thị ngày cuối tháng nếu là 30 hoặc 31
                          if (day == daysInMonth && (day == 28 ||day == 30 || day == 31)) {
                            return Text('$day');
                          }

                          // Ngược lại không hiển thị
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


      Widget buildBarChart() {
        // Tạo dữ liệu cho 12 tháng
        final List<BarChartGroupData> barGroups = List.generate(12, (index) {
          // Dữ liệu mẫu: tháng 7 có số lớn hơn
          double y = (index == 6) ? 91000000 : 3000000;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: y,
                color: Colors.orange,
                width: 16,
                borderRadius: BorderRadius.circular(6),
              )
            ],
          );
        });

        return AspectRatio(
          aspectRatio: 1.8,
          child: BarChart(
            BarChartData(
              barGroups: barGroups,
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1, // ⚠️ Quan trọng để hiện đủ các mốc
                    getTitlesWidget: (value, _) {
                      final int selectedMonthNumber =
                      int.parse(selectedMonth.replaceAll(RegExp(r'[^0-9]'), ''));
                      final int selectedYearNumber =
                      int.parse(selectedYear.replaceAll(RegExp(r'[^0-9]'), ''));
                      final int daysInMonth =
                      getDaysInMonth(selectedMonthNumber, selectedYearNumber);

                      final int day = value.toInt() + 1;

                      // Hiển thị mốc ngày 1, 8, 15, 22 và ngày cuối tháng
                      if (day == 1 || day == 8 || day == 15 || day == 22 || day == daysInMonth) {
                        return Text('$day', style: const TextStyle(fontSize: 10));
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



      @override
      Widget build(BuildContext context) {
        final totalAmount =
        selectedData.fold(0, (sum, item) => sum + item['amount'] as int);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.yellow[700],
            elevation: 0,
            centerTitle: true,
            title: GestureDetector(
              key: _titleKey,
              onTap: () async {
                final RenderBox renderBox =
                _titleKey.currentContext!.findRenderObject() as RenderBox;
                final Offset offset = renderBox.localToGlobal(Offset.zero);
                final Size size = renderBox.size;

                final selected = await showMenu<String>(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx + size.width / 2 - 60,
                    offset.dy + size.height + 5,
                    offset.dx + size.width / 2 + 60,
                    0,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  items: types
                      .map(
                        (type) => PopupMenuItem(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                );

                if (selected != null) {
                  setState(() {
                    selectedType = selected;
                  });
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedType,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.black),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isMonthSelected = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isMonthSelected
                                    ? Colors.black
                                    : Colors.yellow[700],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Tháng',
                                style: TextStyle(
                                  color: isMonthSelected
                                      ? Colors.yellow[700]
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isMonthSelected = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isMonthSelected
                                    ? Colors.yellow[700]
                                    : Colors.black,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Năm',
                                style: TextStyle(
                                  color: isMonthSelected
                                      ? Colors.black
                                      : Colors.yellow[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (isMonthSelected)
                  buildTabList(
                    options: monthOptions,
                    selectedValue: selectedMonth,
                    onTap: (value) => setState(() => selectedMonth = value),
                  )
                else
                  buildTabList(
                    options: yearOptions,
                    selectedValue: selectedYear,
                    onTap: (value) => setState(() => selectedYear = value),
                  ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    SizedBox(
                      height: 280,
                      child: PageView(
                        controller: _pageController,
                        children: [
                          // Biểu đồ tròn
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(
                                PieChartData(
                                  sections: selectedData.map((e) => PieChartSectionData(
                                    color: e['color'],
                                    value: e['amount'].toDouble(),
                                    title: '',
                                    radius: 60,
                                  )).toList(),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 55,
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
                          ),

                          // Biểu đồ đường hoặc cột
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: isMonthSelected ? buildLineChart() : buildBarChart(),
                          ),
                        ],
                      ),
                    ),

                    // 🔽 Thanh chấm tròn trượt biểu đồ
                    const SizedBox(height: 12),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 2,
                      effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 12,
                        activeDotColor: Colors.black,
                        dotColor: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: selectedData.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: item['color'].withOpacity(0.2),
                                  child: Icon(item['icon'],
                                      color: item['color'], size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          Text('${item['percent'].toStringAsFixed(2)}%',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500)),
                                          const SizedBox(width: 10),
                                          Text(
                                            formatCurrency(item['amount']),
                                            style:
                                            const TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: LinearProgressIndicator(
                                          value: item['percent'] / 100,
                                          minHeight: 6,
                                          backgroundColor: Colors.grey[200],
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              item['color']),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }


  // Code Test-------------------------------------------------------------
  // import 'package:flutter/material.dart';
  // import '../../controllers/ThongKe/API_ThongKe.dart';
  // import '../../models/TrangChu/GiaoDich.dart';
  //
  // class GiaoDichScreen extends StatefulWidget {
  //   final int idTaiKhoan;
  //
  //   const GiaoDichScreen({super.key, required this.idTaiKhoan});
  //
  //   @override
  //   State<GiaoDichScreen> createState() => _GiaoDichScreenState();
  // }
  //
  // class _GiaoDichScreenState extends State<GiaoDichScreen> {
  //   final GiaoDichService _service = GiaoDichService();
  //   late Future<List<GiaoDich>> _futureGiaoDich;
  //
  //   @override
  //   void initState() {
  //     super.initState();
  //     _futureGiaoDich = _service.getGiaoDichByTaiKhoan(widget.idTaiKhoan);
  //   }
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(title: const Text('Danh sách Giao Dịch')),
  //       body: FutureBuilder<List<GiaoDich>>(
  //         future: _futureGiaoDich,
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const Center(child: CircularProgressIndicator());
  //           } else if (snapshot.hasError) {
  //             return Center(child: Text('Lỗi: ${snapshot.error}'));
  //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //             return const Center(child: Text('Không có giao dịch nào.'));
  //           } else {
  //             final giaoDiches = snapshot.data!;
  //             return ListView.builder(
  //               itemCount: giaoDiches.length,
  //               itemBuilder: (context, index) {
  //                 final gd = giaoDiches[index];
  //                 return ListTile(
  //                   leading: const Icon(Icons.monetization_on),
  //                   title: Text('${gd.loaiGiaoDich} - ${gd.soTien}'),
  //                   subtitle: Text('${gd.ngayGiaoDich} | Mô tả: ${gd.moTa}'),
  //                   trailing: Text('Danh mục: ${gd.idDanhMuc}'),
  //                 );
  //               },
  //             );
  //           }
  //         },
  //       ),
  //     );
  //   }
  // }

