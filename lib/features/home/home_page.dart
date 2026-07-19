import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noorah/core/user/user_profile_provider.dart';
import 'package:noorah/features/home/widgets/prayer_model.dart';
import 'package:noorah/features/home/widgets/prayer_provider.dart';
import 'package:noorah/features/home/widgets/daily_ayah_card.dart';
import 'package:noorah/features/home/widgets/greeting_header.dart';
import 'package:noorah/features/home/widgets/home_bottom_navigation.dart';
import 'package:noorah/features/home/widgets/prayer_countdown_card.dart';
import 'package:noorah/features/home/widgets/prayer_timeline.dart';
import 'package:noorah/features/home/widgets/quick_actions.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? timer;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    updateTime();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  void updateTime() {
    setState(() {
      now = DateTime.now();
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prayer = ref.watch(prayerProvider);
    final userProfile = ref.watch(userProfileProvider);

    if (!userProfile.isLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!userProfile.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/setup');
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      bottomNavigationBar: const HomeBottomNavigation(currentIndex: 0),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GreetingHeader(userName: userProfile.userName),

              // هنا هنربطها بالـ API بعدين
              prayer.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),

                error: (error, stack) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Error loading prayer times"),
                ),

                data: (data) {
                  final nextPrayer = NextPrayer.fromPrayerTimes(data, now);

                  return Column(
                    children: [
                      PrayerCountdownCard(
                        prayerName: nextPrayer.name,
                        countdown: nextPrayer.countdown,
                        location: userProfile.location,
                      ),
                      PrayerTimeline(
                        prayers: data,
                        activePrayerName: nextPrayer.name,
                      ),
                    ],
                  );
                },
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

class NextPrayer {
  final String name;
  final String countdown;

  const NextPrayer({required this.name, required this.countdown});

  static NextPrayer fromPrayerTimes(PrayerModel prayers, DateTime now) {
    final schedule = [
      _PrayerTime(name: 'Fajr', time: prayers.fajr),
      _PrayerTime(name: 'Dhuhr', time: prayers.dhuhr),
      _PrayerTime(name: 'Asr', time: prayers.asr),
      _PrayerTime(name: 'Maghrib', time: prayers.maghrib),
      _PrayerTime(name: 'Isha', time: prayers.isha),
    ];

    for (final prayer in schedule) {
      final dateTime = prayer.toDateTime(now);
      if (dateTime != null && dateTime.isAfter(now)) {
        return NextPrayer(
          name: '${prayer.name} Prayer',
          countdown: _formatDuration(dateTime.difference(now)),
        );
      }
    }

    final fajrTomorrow = schedule.first.toDateTime(
      now.add(const Duration(days: 1)),
    );

    return NextPrayer(
      name: 'Fajr Prayer',
      countdown: fajrTomorrow == null
          ? DateFormat('HH:mm:ss').format(now)
          : _formatDuration(fajrTomorrow.difference(now)),
    );
  }

  static String _formatDuration(Duration duration) {
    final positiveDuration = duration.isNegative ? Duration.zero : duration;
    final hours = positiveDuration.inHours.toString().padLeft(2, '0');
    final minutes = positiveDuration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = positiveDuration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }
}

class _PrayerTime {
  final String name;
  final String time;

  const _PrayerTime({required this.name, required this.time});

  DateTime? toDateTime(DateTime date) {
    final cleanTime = time.split(' ').first.trim();
    final parts = cleanTime.split(':');
    if (parts.length < 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;

    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
