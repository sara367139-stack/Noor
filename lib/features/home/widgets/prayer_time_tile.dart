import 'package:flutter/material.dart';

import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class PrayerTimeTile extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final bool isActive;
  final IconData icon;

  const PrayerTimeTile({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: isActive
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Text(
              prayerName,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isActive
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          Text(
            prayerTime,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isActive
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}