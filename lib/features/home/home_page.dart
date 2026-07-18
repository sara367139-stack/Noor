import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
  String currentTime = "";


  @override
  void initState() {
    super.initState();

    updateTime();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        updateTime();
      },
    );
  }


  void updateTime() {

    setState(() {

      currentTime =
          DateFormat('HH:mm:ss').format(
            DateTime.now(),
          );

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

    return Scaffold(

      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,


      bottomNavigationBar:
          const HomeBottomNavigation(
            currentIndex: 0,
          ),



      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(

            children: [


              const GreetingHeader(
                userName: "Noor",
              ),



              PrayerCountdownCard(

                prayerName: "Asr Prayer",

                countdown: currentTime,

                location: "Minya, Egypt",

              ),



              // هنا هنربطها بالـ API بعدين
       prayer.when(

  loading: () => const Padding(
    padding: EdgeInsets.all(20),
    child: CircularProgressIndicator(),
  ),


  error: (error, stack) => Padding(
    padding: const EdgeInsets.all(20),
    child: Text(
      "Error loading prayer times",
    ),
  ),


  data: (data) {

    return PrayerTimeline(
      prayers: data,
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