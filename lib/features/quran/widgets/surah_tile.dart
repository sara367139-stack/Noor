import 'package:flutter/material.dart';
import 'package:noorah/features/quran/widgets/surah_details_page.dart';
import 'package:noorah/features/quran/widgets/surah_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';


class SurahTile extends StatelessWidget {
  final SurahModel surah;

  const SurahTile({
    super.key,
    required this.surah,
  });

  @override
  Widget build(BuildContext context) {
   return InkWell(
  borderRadius: BorderRadius.circular(AppRadius.lg),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SurahDetailsPage(
          surah: surah,
        ),
      ),
    );
  },
  child: Container(
    margin: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.xs,
    ),
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(AppRadius.lg),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.primary,
          child: Text(
            surah.number.toString(),
 style: TextStyle(
  color: Theme.of(context).colorScheme.onPrimary,
  fontWeight: FontWeight.bold,
),
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                surah.englishName,
                style: AppTextStyles.heading3,
              ),

              const SizedBox(height: 2),

              Text(
                surah.arabicName,
                style: AppTextStyles.bodyMedium,
              ),

              const SizedBox(height: 4),

              Text(
                "${surah.versesCount} Verses • ${surah.revelationType}",
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),

        const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: AppColors.primary,
        ),
      ],
    ),
  ),
);
  }
}