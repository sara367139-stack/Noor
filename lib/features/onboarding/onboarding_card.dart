import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class OnboardingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppSizes.iconXLarge,
            color: AppColors.primary,
          ),

          const SizedBox(height: AppSpacing.xl),

          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1,
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}