import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavItemModel {
  final IconData icon;
  final IconData outlineIcon;
  final String label;

  const NavItemModel({
    required this.icon,
    required this.outlineIcon,
    required this.label,
  });
}

class MainNavigationController with ChangeNotifier {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    if (selectedIndex == index) return;

    HapticFeedback.selectionClick();
    selectedIndex = index;
    notifyListeners();
  }
}
