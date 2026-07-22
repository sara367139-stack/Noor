import 'package:flutter/material.dart';
import 'package:noorah/features/home/widgets/prayer_model.dart';
import 'package:noorah/l10n/app_localizations.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

import 'prayer_time_tile.dart';

class PrayerTimeline extends StatelessWidget {
  final PrayerModel prayers;
  final String activePrayerName;

  const PrayerTimeline({
    super.key,
    required this.prayers,
    required this.activePrayerName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(l10n.todayPrayers, style: AppTextStyles.heading3),

          const SizedBox(height: AppSpacing.md),

          PrayerTimeTile(
            prayerName: l10n.fajr,
            prayerTime: prayers.fajr,
            icon: Icons.wb_twilight,
            isActive: activePrayerName.startsWith('Fajr'),
          ),

          PrayerTimeTile(
            prayerName: l10n.dhuhr,
            prayerTime: prayers.dhuhr,
            icon: Icons.sunny,
            isActive: activePrayerName.startsWith('Dhuhr'),
          ),

          PrayerTimeTile(
            prayerName: l10n.asr,
            prayerTime: prayers.asr,
            icon: Icons.wb_sunny,
            isActive: activePrayerName.startsWith('Asr'),
          ),

          PrayerTimeTile(
            prayerName: l10n.maghrib,
            prayerTime: prayers.maghrib,
            icon: Icons.nights_stay_outlined,
            isActive: activePrayerName.startsWith('Maghrib'),
          ),

          PrayerTimeTile(
            prayerName: l10n.isha,
            prayerTime: prayers.isha,
            icon: Icons.dark_mode_outlined,
            isActive: activePrayerName.startsWith('Isha'),
          ),
        ],
      ),
    );
  }
}
