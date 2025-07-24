// import 'package:flutter/material.dart';
//
// class TabList extends StatelessWidget {
//   final List<String> options;
//   final String selectedValue;
//   final Function(String) onTap;
//
//   const TabList({
//     super.key,
//     required this.options,
//     required this.selectedValue,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: options.length,
//         itemBuilder: (context, index) {
//           final label = options[index];
//           final isSelected = label == selectedValue;
//           return GestureDetector(
//             onTap: () => onTap(label),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     label,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight:
//                       isSelected ? FontWeight.bold : FontWeight.normal,
//                       color: isSelected ? Colors.black : Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   if (isSelected)
//                     Container(
//                       height: 2,
//                       width: 40,
//                       color: Colors.yellow[700],
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
// class TabList extends StatelessWidget {
//   final List<String> options;
//   final String selectedValue;
//   final void Function(String) onTap;
//
//   const TabList({
//     super.key,
//     required this.options,
//     required this.selectedValue,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: options.length,
//         itemBuilder: (context, index) {
//           final item = options[index];
//           final isSelected = item == selectedValue;
//
//           return GestureDetector(
//             onTap: () => onTap(item),
//             child: Container(
//               margin: const EdgeInsets.only(right: 12),
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.black : Colors.grey[200],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 item,
//                 style: TextStyle(
//                   color: isSelected ? Colors.yellow[700] : Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TabList extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final void Function(String) onTap;
  final ScrollController? scrollController; // 👈 thêm

  const TabList({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onTap,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        controller: scrollController, // 👈 gán controller
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final item = options[index];
          final isSelected = item == selectedValue;

          return GestureDetector(
            onTap: () => onTap(item),
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: isSelected ? Colors.yellow[700] : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}





