// import 'package:flutter/material.dart';
// // import 'package:noorah/features/home/services/daily_ayah_service.dart';
// import 'package:noorah/features/home/widgets/daily_ayah_service.dart';
// import 'package:noorah/l10n/app_localizations.dart';

// import '../../../../../core/constants/app_radius.dart';
// import '../../../../../core/constants/app_spacing.dart';
// import '../../../../../core/theme/app_text_styles.dart';

// class DailyAyahCard extends StatelessWidget {
//   const DailyAyahCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final lang = AppLocalizations.of(context)!;

//     return FutureBuilder<DailyAyah>(
//       future: DailyAyahService.getAyahOfTheDay(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         final ayah = snapshot.data!;

//         return Container(
//           width: double.infinity,
//           margin: const EdgeInsets.symmetric(
//             horizontal: AppSpacing.lg,
//             vertical: AppSpacing.md,
//           ),
//           padding: const EdgeInsets.all(AppSpacing.lg),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(AppRadius.lg),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 lang.dailyAyah,
//                 style: AppTextStyles.heading3.copyWith(
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//               ),

//               const SizedBox(height: AppSpacing.md),

//               Text(
//                 ayah.verse,
//                 style: AppTextStyles.bodyMedium.copyWith(
//                   color: Theme.of(context).colorScheme.onSurface,
//                   height: 1.8,
//                 ),
//               ),

//               const SizedBox(height: AppSpacing.md),

//               Text(
//                 "${lang.surah} ${ayah.surahName} • ${ayah.verseNumber}",
//                 style: AppTextStyles.bodySmall.copyWith(
//                   color: Theme.of(context)
//                       .colorScheme
//                       .onSurface
//                       // ignore: deprecated_member_use
//                       .withOpacity(.7),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class DailyAyahCard extends StatelessWidget {
  const DailyAyahCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daily Ayah",
            style: AppTextStyles.heading3.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            "Indeed, with hardship comes ease.",
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            "Surah Ash-Sharh",
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurface
                  // ignore: deprecated_member_use
                  .withOpacity(.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
