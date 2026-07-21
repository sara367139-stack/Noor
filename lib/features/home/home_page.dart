import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noorah/core/users/user_profile_provider.dart';


import 'package:noorah/features/home/widgets/daily_ayah_card.dart';
import 'package:noorah/features/home/widgets/greeting_header.dart';
import 'package:noorah/features/home/widgets/home_bottom_navigation.dart';
import 'package:noorah/features/home/widgets/prayer_countdown_card.dart';
import 'package:noorah/features/home/widgets/prayer_provider.dart';
import 'package:noorah/features/home/widgets/prayer_timeline.dart';
import 'package:noorah/features/home/widgets/quick_actions.dart';
import 'package:noorah/l10n/app_localizations.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? timer;

  String currentTime = "";
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    updateTime();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => updateTime(),
    );
  }

  void updateTime() {
    setState(() {
      currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
      now = DateTime.now();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String getNextPrayerName(dynamic prayer, AppLocalizations lang) {
    final now = DateTime.now();

    final prayers = [
      {"name": lang.fajr, "time": prayer.fajr},
      {"name": lang.dhuhr, "time": prayer.dhuhr},
      {"name": lang.asr, "time": prayer.asr},
      {"name": lang.maghrib, "time": prayer.maghrib},
      {"name": lang.isha, "time": prayer.isha},
    ];

    for (final p in prayers) {
      final parts = (p["time"] as String).split(":");

      final prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (prayerTime.isAfter(now)) {
        return p["name"] as String;
      }
    }

    return lang.fajr;
  }

  String getCountdown(dynamic prayer) {
    final now = DateTime.now();

    final times = [
      prayer.fajr,
      prayer.dhuhr,
      prayer.asr,
      prayer.maghrib,
      prayer.isha,
    ];

    for (final t in times) {
      final parts = t.split(":");

      final prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (prayerTime.isAfter(now)) {
        final diff = prayerTime.difference(now);

        return "${diff.inHours.toString().padLeft(2, '0')}:"
            "${(diff.inMinutes % 60).toString().padLeft(2, '0')}:"
            "${(diff.inSeconds % 60).toString().padLeft(2, '0')}";
      }
    }

    final parts = prayer.fajr.split(":");

    final tomorrowFajr = DateTime(
      now.year,
      now.month,
      now.day + 1,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );

    final diff = tomorrowFajr.difference(now);

    return "${diff.inHours.toString().padLeft(2, '0')}:"
        "${(diff.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(diff.inSeconds % 60).toString().padLeft(2, '0')}";
  }

 @override
Widget build(BuildContext context) {
  final prayer = ref.watch(prayerProvider);
  final lang = AppLocalizations.of(context)!;
 final userProfile = ref.watch(userProfileProvider);
  return Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,

    bottomNavigationBar: const HomeBottomNavigation(
      currentIndex: 0,
    ),

    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GreetingHeader(
  userName: userProfile.userName,
),
            // const GreetingHeader(
            //   userName: "Noor",
            // ),

            prayer.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),

              error: (_, _) => Padding(
                padding: const EdgeInsets.all(20),
                child: Text(lang.errorLoadingPrayerTimes),
              ),

              data: (data) => PrayerCountdownCard(
                prayerName: getNextPrayerName(data, lang),
                countdown: getCountdown(data),
               location: userProfile.location,
              ),
            ),

            prayer.when(
              loading: () => const SizedBox(),

              error: (_, _) => const SizedBox(),

              data: (data) => PrayerTimeline(
                prayers: data,
              ),
            ),

            const QuickActions(),

            const DailyAyahCard(),
          ],
        ),
      ),
    ),
  );
}
}