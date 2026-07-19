import 'package:flutter/material.dart';
import 'package:noorah/features/home/widgets/prayer_model.dart';
import 'package:noorah/l10n/app_localizations.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'prayer_time_tile.dart';

class PrayerTimeline extends StatelessWidget {
  final PrayerModel prayers;

  const PrayerTimeline({
    super.key,
    required this.prayers,
  });

  DateTime _parseTime(String time) {
    final now = DateTime.now();

    final parts = time.split(":");

    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  String _currentPrayer() {
    final now = DateTime.now();

    final fajr = _parseTime(prayers.fajr);
    final dhuhr = _parseTime(prayers.dhuhr);
    final asr = _parseTime(prayers.asr);
    final maghrib = _parseTime(prayers.maghrib);
    final isha = _parseTime(prayers.isha);

    if (now.isAfter(isha)) return "isha";
    if (now.isAfter(maghrib)) return "maghrib";
    if (now.isAfter(asr)) return "asr";
    if (now.isAfter(dhuhr)) return "dhuhr";
    if (now.isAfter(fajr)) return "fajr";

    return "";
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final activePrayer = _currentPrayer();

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang.todayPrayers,
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: AppSpacing.md),

          PrayerTimeTile(
            prayerName: lang.fajr,
            prayerTime: prayers.fajr,
            icon: Icons.wb_twilight,
            isActive: activePrayer == "fajr",
          ),

          PrayerTimeTile(
            prayerName: lang.dhuhr,
            prayerTime: prayers.dhuhr,
            icon: Icons.sunny,
            isActive: activePrayer == "dhuhr",
          ),

          PrayerTimeTile(
            prayerName: lang.asr,
            prayerTime: prayers.asr,
            icon: Icons.wb_sunny,
            isActive: activePrayer == "asr",
          ),

          PrayerTimeTile(
            prayerName: lang.maghrib,
            prayerTime: prayers.maghrib,
            icon: Icons.nights_stay_outlined,
            isActive: activePrayer == "maghrib",
          ),

          PrayerTimeTile(
            prayerName: lang.isha,
            prayerTime: prayers.isha,
            icon: Icons.dark_mode_outlined,
            isActive: activePrayer == "isha",
          ),
        ],
      ),
    );
  }
}