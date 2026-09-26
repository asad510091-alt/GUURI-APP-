import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GuuriBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GuuriBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMuted,
      backgroundColor: Colors.white,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined), label: 'Applications'),
        BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined), label: 'Payments'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
