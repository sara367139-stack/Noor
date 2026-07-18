import 'package:flutter/material.dart';
import 'package:noorah/features/home/widgets/prayer_model.dart';

import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

import 'prayer_time_tile.dart';

class PrayerTimeline extends StatelessWidget {

  final PrayerModel prayers;

  const PrayerTimeline({
    super.key,
    required this.prayers,
  });


  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(AppSpacing.lg),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            "Today's Prayers",
            style: AppTextStyles.heading3,
          ),


          const SizedBox(
            height: AppSpacing.md,
          ),


          PrayerTimeTile(
            prayerName: "Fajr",
            prayerTime: prayers.fajr,
            icon: Icons.wb_twilight,
          ),


          PrayerTimeTile(
            prayerName: "Dhuhr",
            prayerTime: prayers.dhuhr,
            icon: Icons.sunny,
          ),


          PrayerTimeTile(
            prayerName: "Asr",
            prayerTime: prayers.asr,
            icon: Icons.wb_sunny,
            isActive: true,
          ),


          PrayerTimeTile(
            prayerName: "Maghrib",
            prayerTime: prayers.maghrib,
            icon: Icons.nights_stay_outlined,
          ),


          PrayerTimeTile(
            prayerName: "Isha",
            prayerTime: prayers.isha,
            icon: Icons.dark_mode_outlined,
          ),


        ],
      ),
    );
  }
}