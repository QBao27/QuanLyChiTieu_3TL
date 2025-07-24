// import 'package:appquanlychitieu/views/ThongKe/pie_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// import 'List_item.dart';
// import 'Tab_List.dart';
// import 'bar_chart.dart';
// import 'line_chart.dart';
//
//
// class ThongKeScreen extends StatefulWidget {
//   const ThongKeScreen({super.key});
//
//   @override
//   State<ThongKeScreen> createState() => _ThongKeScreenState();
// }
//
// class _ThongKeScreenState extends State<ThongKeScreen> {
//   final GlobalKey _titleKey = GlobalKey();
//
//   bool isMonthSelected = true;
//   String selectedType = 'Chi tiêu';
//   final List<String> types = ['Chi tiêu', 'Thu nhập'];
//
//   final List<String> monthOptions = [
//     'Tháng 1',
//     'Tháng 2',
//     'Tháng 3',
//     'Tháng 4',
//     'Tháng 5',
//     'Tháng 6',
//     'Tháng 7',
//     'Tháng 8',
//     'Tháng 9',
//     'Tháng 10',
//     'Tháng 11',
//     'Tháng 12'
//   ];
//   String selectedMonth = 'Tháng ${DateTime.now().month}';
//
//   late List<String> yearOptions;
//   String selectedYear = 'Năm ${DateTime.now().year}';
//
//   static const aonguoc = Icons.flight;
//
//   final List<Map<String, dynamic>> dataChiTieu = const [
//     {
//       'name': 'Giáo dục',
//       'amount': 8000000,
//       'percent': 97.88,
//       'color': Colors.indigo,
//       'icon': Icons.book,
//     },
//     {
//       'name': 'Du lịch',
//       'amount': 90000,
//       'percent': 1.10,
//       'color': Colors.purple,
//       'icon': aonguoc,
//     },
//     {
//       'name': 'Thiết bị điện tử',
//       'amount': 83055,
//       'percent': 1.01,
//       'color': Colors.deepOrange,
//       'icon': Icons.devices,
//     },
//   ];
//
//   final List<Map<String, dynamic>> dataThuNhap = const [
//     {
//       'name': 'Lương',
//       'amount': 10000000,
//       'percent': 80.0,
//       'color': Colors.grey,
//       'icon': Icons.attach_money,
//     },
//     {
//       'name': 'Kinh doanh',
//       'amount': 2000000,
//       'percent': 16.0,
//       'color': Colors.redAccent,
//       'icon': Icons.business_center,
//     },
//     {
//       'name': 'Lãi tiết kiệm',
//       'amount': 500000,
//       'percent': 4.0,
//       'color': Colors.lightBlue,
//       'icon': Icons.savings,
//     },
//   ];
//
//   final PageController _pageController = PageController();
//
//   @override
//   void initState() {
//     super.initState();
//     final now = DateTime.now();
//     yearOptions = [
//       for (int year = 2020; year <= now.year; year++) 'Năm $year'
//     ];
//   }
//
//   List<Map<String, dynamic>> get selectedData =>
//       selectedType == 'Chi tiêu' ? dataChiTieu : dataThuNhap;
//
//   int getDaysInMonth(int month, int year) {
//     return DateTime(year, month + 1, 0).day;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final totalAmount =
//     selectedData.fold(0, (sum, item) => sum + item['amount'] as int);
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.yellow[700],
//         elevation: 0,
//         centerTitle: true,
//         title: GestureDetector(
//           key: _titleKey,
//           onTap: () async {
//             final RenderBox renderBox =
//             _titleKey.currentContext!.findRenderObject() as RenderBox;
//             final Offset offset = renderBox.localToGlobal(Offset.zero);
//             final Size size = renderBox.size;
//
//             final selected = await showMenu<String>(
//               context: context,
//               position: RelativeRect.fromLTRB(
//                 offset.dx + size.width / 2 - 60,
//                 offset.dy + size.height + 5,
//                 offset.dx + size.width / 2 + 60,
//                 0,
//               ),
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               items: types
//                   .map(
//                     (type) => PopupMenuItem(
//                   value: type,
//                   child: Text(
//                     type,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               )
//                   .toList(),
//             );
//
//             if (selected != null) {
//               setState(() {
//                 selectedType = selected;
//               });
//             }
//           },
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 selectedType,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const Icon(Icons.arrow_drop_down, color: Colors.black),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             isMonthSelected = true;
//                           });
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: isMonthSelected
//                                 ? Colors.black
//                                 : Colors.yellow[700],
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(12),
//                               bottomLeft: Radius.circular(12),
//                             ),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             'Tháng',
//                             style: TextStyle(
//                               color: isMonthSelected
//                                   ? Colors.yellow[700]
//                                   : Colors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             isMonthSelected = false;
//                           });
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: isMonthSelected
//                                 ? Colors.yellow[700]
//                                 : Colors.black,
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(12),
//                               bottomRight: Radius.circular(12),
//                             ),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             'Năm',
//                             style: TextStyle(
//                               color: isMonthSelected
//                                   ? Colors.black
//                                   : Colors.yellow[700],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             isMonthSelected
//                 ? TabList(
//               options: monthOptions,
//               selectedValue: selectedMonth,
//               onTap: (value) => setState(() => selectedMonth = value),
//             )
//                 : TabList(
//               options: yearOptions,
//               selectedValue: selectedYear,
//               onTap: (value) => setState(() => selectedYear = value),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               children: [
//                 SizedBox(
//                   height: 280,
//                   child: PageView(
//                     controller: _pageController,
//                     children: [
//                       PieChartWidget(
//                         selectedData: selectedData,
//                         totalAmount: totalAmount,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: isMonthSelected
//                             ? LineChartWidget(
//                           selectedMonth: selectedMonth,
//                           selectedYear: selectedYear,
//                           getDaysInMonth: getDaysInMonth,
//                         )
//                             : const BarChartWidget(),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 SmoothPageIndicator(
//                   controller: _pageController,
//                   count: 2,
//                   effect: WormEffect(
//                     dotHeight: 10,
//                     dotWidth: 10,
//                     spacing: 12,
//                     activeDotColor: Colors.black,
//                     dotColor: Colors.grey.shade400,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListTileItem(data: selectedData),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/ThongKe/API_ThongKe.dart';
import '../../models/ThongKe/ThongKe_Models.dart';

import 'pie_chart.dart';
import 'line_chart.dart';
import 'bar_chart.dart';
import 'List_item.dart';
import 'Tab_List.dart';

class ThongKeScreen extends StatefulWidget {
  final int idTaiKhoan;

  const ThongKeScreen({super.key, required this.idTaiKhoan});

  @override
  State<ThongKeScreen> createState() => _ThongKeScreenState();
}

class _ThongKeScreenState extends State<ThongKeScreen> {
  final GlobalKey _titleKey = GlobalKey();
  final PageController _pageController = PageController();

  final GiaoDichService _service = GiaoDichService();

  final ScrollController _monthScrollController = ScrollController();
  final ScrollController _yearScrollController = ScrollController();


  late Future<List<GiaoDich>> _futureGiaoDich;

  bool isMonthSelected = true;
  String selectedType = 'Chi tiêu';

  final List<String> types = ['Chi tiêu', 'Thu nhập'];


  final List<String> monthOptions = [
    'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4',
    'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8',
    'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'
  ];
  String selectedMonth = 'Tháng ${DateTime.now().month}';

  late List<String> yearOptions;
  String selectedYear = 'Năm ${DateTime.now().year}';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    yearOptions = [
      for (int year = 2000; year <= now.year; year++) 'Năm $year'
    ];
    _futureGiaoDich = _service.getGiaoDichByTaiKhoan(widget.idTaiKhoan);_scrollToSelected;
  }

  int getDaysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  void _scrollToSelected(ScrollController controller, int index) {
    const itemWidth = 100.0; // 👈 bạn tự đặt cố định
    controller.animateTo(
      index * itemWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder<List<GiaoDich>>(
        future: _futureGiaoDich,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          final now = DateTime.now();
          if (isMonthSelected) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToSelected(_monthScrollController, now.month - 1);
            });
          } else {
            final index = yearOptions.indexOf('Năm ${now.year}');
            if (index >= 0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToSelected(_yearScrollController, index);
              });
            }
          }

          final List<GiaoDich> allData = snapshot.data ?? [];


          // Lấy ra các tháng/năm có dữ liệu
          final monthsWithData = allData.map((gd) {
            final date = DateTime.parse(gd.ngayGiaoDich);
            return date.month;
          }).toSet();

          final yearsWithData = allData.map((gd) {
            final date = DateTime.parse(gd.ngayGiaoDich);
            return date.year;
          }).toSet();


          final filtered = allData.where((e) {
            if (selectedType == 'Chi tiêu' && e.loaiGiaoDich.toLowerCase() != 'chi') return false;
            if (selectedType == 'Thu nhập' && e.loaiGiaoDich.toLowerCase() != 'thu') return false;

            final date = DateTime.parse(e.ngayGiaoDich);
            if (isMonthSelected) {
              final selectedMonthInt = int.tryParse(selectedMonth.replaceAll('Tháng ', '')) ?? 0;
              return date.month == selectedMonthInt;
            } else {
              final selectedYearInt = int.tryParse(selectedYear.replaceAll('Năm ', '')) ?? 0;
              return date.year == selectedYearInt;
            }
          }).toList();

          if (filtered.isEmpty) {
            return Column(
              children: [
                const SizedBox(height: 20),
                buildTabSwitch(),
                const SizedBox(height: 20),
                if (isMonthSelected)
                  TabList(
                    options: monthOptions,
                    selectedValue: selectedMonth,
                    scrollController: _monthScrollController,
                    onTap: (value) => setState(() => selectedMonth = value),
                  )
                else
                  TabList(
                    options: yearOptions,
                    selectedValue: selectedYear,
                    scrollController: _yearScrollController,
                    onTap: (value) => setState(() => selectedYear = value),
                  ),
                const SizedBox(height: 50),
                const Text(
                  'Chưa có dữ liệu',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            );
          }

          final totalAmount = filtered.fold<double>(0, (sum, item) => sum + item.soTien);

          return Column(
            children: [
              const SizedBox(height: 20),
              buildTabSwitch(),
              const SizedBox(height: 20),
              isMonthSelected
                  ? TabList(
                options: monthOptions,
                selectedValue: selectedMonth,
                scrollController: _monthScrollController,
                onTap: (value) => setState(() => selectedMonth = value),
              )
                  : TabList(
                options: yearOptions,
                selectedValue: selectedYear,
                scrollController: _yearScrollController,
                onTap: (value) => setState(() => selectedYear = value),
              ),

              const SizedBox(height: 20),
              SizedBox(
                height: 280,
                child: PageView(
                  controller: _pageController,
                  children: [
                    PieChartWidget(
                      giaoDiches: filtered,
                      totalAmount: totalAmount,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: isMonthSelected
                          ? LineChartWidget(
                        giaoDiches: filtered,
                        selectedMonth: selectedMonth,
                        selectedYear: selectedYear,
                        getDaysInMonth: getDaysInMonth,
                      )
                          : BarChartWidget(giaoDiches: filtered),
                    ),
                  ],
                ),
              ),
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
              const SizedBox(height: 10),
              Expanded(
                child: ListTileItem(data: filtered),
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
                .map((type) => PopupMenuItem(
              value: type,
              child: Text(
                type,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ))
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
    );
  }

  Widget buildTabSwitch() {
    return Padding(
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
                    color: isMonthSelected ? Colors.black : Colors.yellow[700],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Tháng',
                    style: TextStyle(
                      color: isMonthSelected ? Colors.yellow[700] : Colors.black,
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
                    color: isMonthSelected ? Colors.yellow[700] : Colors.black,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Năm',
                    style: TextStyle(
                      color: isMonthSelected ? Colors.black : Colors.yellow[700],
                      fontWeight: FontWeight.w500,
                    ),
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


