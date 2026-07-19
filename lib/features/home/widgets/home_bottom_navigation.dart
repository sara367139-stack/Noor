import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../../../../../core/constants/app_colors.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const HomeBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/quran');
            break;
          case 2:
            context.go('/dhikr');
            break;
          case 3:
            context.go('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Quran'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Dhikr'),
        BottomNavigationBarItem(
          icon: Icon(Icons.tune_rounded),
          label: 'Settings',
        ),
      ],
    );
  }
}
