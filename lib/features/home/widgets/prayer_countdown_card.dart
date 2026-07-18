import 'package:flutter/material.dart';

import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class PrayerCountdownCard extends StatelessWidget {
  final String prayerName;
  final String countdown;
  final String location;

  const PrayerCountdownCard({
    super.key,
    required this.prayerName,
    required this.countdown,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Column(
          children: [
            Text(
              "Up Next",
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Icon(
              Icons.mosque_rounded,
              size: 45,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: AppSpacing.md),

            Text(
              prayerName,
              style: AppTextStyles.heading2.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            Text(
              countdown,
              style: AppTextStyles.displaySmall.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(width: 6),

                Text(
                  location,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        // ignore: deprecated_member_use
                        .withOpacity(.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}