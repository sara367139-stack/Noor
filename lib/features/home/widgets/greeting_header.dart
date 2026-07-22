// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hijri/hijri_calendar.dart';
// import 'package:noorah/l10n/app_localizations.dart';

// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_radius.dart';
// import '../../../../../core/constants/app_spacing.dart';
// import '../../../../../core/theme/app_text_styles.dart';

// class GreetingHeader extends StatelessWidget {
//   final String userName;

//   const GreetingHeader({
//     super.key,
//     required this.userName,
//   });

//   String getGreeting(AppLocalizations lang) {
//     final hour = DateTime.now().hour;

//     if (hour < 12) {
//       return lang.goodMorning;
//     } else if (hour < 17) {
//       return lang.goodAfternoon;
//     } else {
//       return lang.goodEvening;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final lang = AppLocalizations.of(context)!;
//     // ignore: unused_local_variable
//     final hijri = HijriCalendar.now();
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppSpacing.lg,
//         vertical: AppSpacing.md,
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               borderRadius: BorderRadius.circular(AppRadius.full),
//             ),
//             child: Icon(
//               Icons.person,
//               color: Theme.of(context).colorScheme.onPrimary,
//             ),
//           ),

//           const SizedBox(width: AppSpacing.md),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   getGreeting(lang),
//                   style: AppTextStyles.bodySmall.copyWith(
//                     color: Theme.of(context)
//                         .colorScheme
//                         .onSurface
//                         // ignore: deprecated_member_use
//                         .withOpacity(.7),
//                   ),
//                 ),
// const SizedBox(height: 4),

// Text(
//   "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ",
//   style: AppTextStyles.bodySmall.copyWith(
//     color: Theme.of(context)
//         .colorScheme
//         .onSurface
//         // ignore: deprecated_member_use
//         .withOpacity(.7),
//   ),
// ),
//               ],
//             ),
//           ),

//           IconButton(
//             onPressed: () {
//               context.push("/profile");
//             },
//             icon: const Icon(
//               Icons.settings_outlined,
//               color: AppColors.primary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class GreetingHeader extends StatelessWidget {
  final String userName;

  const GreetingHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final displayName = userName.trim();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Assalamu Alaikum",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurface
                        // ignore: deprecated_member_use
                        .withOpacity(.7),
                  ),
                ),

                Text(
                  displayName,
                  style: AppTextStyles.heading3.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push('/profile'),
            icon: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
