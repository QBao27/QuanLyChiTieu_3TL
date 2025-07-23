import 'package:flutter/material.dart';

IconData getIconData(String iconName) {
  const iconMap = {
    'shopping_cart_outlined': Icons.shopping_cart_outlined,
    'restaurant_outlined': Icons.restaurant_outlined,
    'phone_android_outlined': Icons.phone_android_outlined,
    'headset_mic_rounded': Icons.headset_mic_rounded,
    'book_online': Icons.book_online,
    'brush_outlined': Icons.brush_outlined,
    'directions_bike_outlined': Icons.directions_bike_outlined,
    'people_alt_outlined': Icons.people_alt_outlined,
    'directions_bus_outlined': Icons.directions_bus_outlined,
    'checkroom_rounded': Icons.checkroom_rounded,
    'directions_car_filled_outlined': Icons.directions_car_filled_outlined,
    'liquor_outlined': Icons.liquor_outlined,
    'all_inbox_outlined': Icons.all_inbox_outlined,
    'computer_outlined': Icons.computer_outlined,
    'flight_outlined': Icons.flight_outlined,
    'health_and_safety_outlined': Icons.health_and_safety_outlined,
    'pets_outlined': Icons.pets_outlined,
    'build_outlined': Icons.build_outlined,
    'home_outlined': Icons.home_outlined,
    'card_giftcard_outlined': Icons.card_giftcard_outlined,
    'favorite_border_outlined': Icons.favorite_border_outlined,
    'confirmation_num_outlined': Icons.confirmation_num_outlined,
    'fastfood_outlined': Icons.fastfood_outlined,
    'child_care_outlined': Icons.child_care_outlined,
    'eco_outlined': Icons.eco_outlined,
    'local_florist_outlined': Icons.local_florist_outlined,
    'receipt_outlined': Icons.receipt_outlined,
    'more_horiz_outlined': Icons.more_horiz_outlined,
    'attach_money': Icons.attach_money,
    'trending_up_outlined': Icons.trending_up_outlined,
    'money_outlined': Icons.money_outlined,
    'work_history_outlined': Icons.work_history_outlined,
  };

  return iconMap[iconName] ?? Icons.help_outline;
}
