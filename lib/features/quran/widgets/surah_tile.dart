import 'package:flutter/material.dart';
import 'package:noorah/features/quran/widgets/surah_details_page.dart';
import 'package:noorah/features/quran/widgets/surah_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class SurahTile extends StatelessWidget {
  final SurahModel surah;

  const SurahTile({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SurahDetailsPage(surah: surah)),
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
          border: Border.all(color: colorScheme.primary.withValues(alpha: .08)),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .14),
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Text(
                surah.number.toString().padLeft(3, '0'),
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.primary,
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
                    style: AppTextStyles.heading3.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${surah.versesCount} Verses - ${surah.revelationType}",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: .62),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 96),
              child: Text(
                surah.arabicName,
                textDirection: TextDirection.rtl,
                style: AppTextStyles.heading3.copyWith(
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
