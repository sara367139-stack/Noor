// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:noorah/l10n/app_localizations.dart';

// class HomeBottomNavigation extends StatelessWidget {
//   final int currentIndex;

//   const HomeBottomNavigation({
//     super.key,
//     required this.currentIndex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final lang = AppLocalizations.of(context)!;

//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: (index) {
//         switch (index) {
//           case 0:
//             context.go('/home');
//             break;
//           case 1:
//             context.go('/quran');
//             break;
//           case 2:
//             context.go('/dhikr');
//             break;
//           case 3:
//             context.go('/profile');
//             break;
//         }
//       },
//       items: [
//         BottomNavigationBarItem(
//           icon: const Icon(Icons.home),
//           label: lang.home,
//         ),
//         BottomNavigationBarItem(
//           icon: const Icon(Icons.menu_book),
//           label: lang.quran,
//         ),
//         BottomNavigationBarItem(
//           icon: const Icon(Icons.favorite),
//           label: lang.adhkar,
//         ),
//         BottomNavigationBarItem(
//           icon: const Icon(Icons.person),
//           label: lang.profile,
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../../../../../core/constants/app_colors.dart';

// import '../../../../../core/constants/app_colors.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const HomeBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
