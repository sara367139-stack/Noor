import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class QuranAppBar extends StatelessWidget {
  const QuranAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
         Text(
  "Quran",
  style: AppTextStyles.heading1.copyWith(
    color: Theme.of(context).colorScheme.onSurface,
  ),
),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
             color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.search,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}