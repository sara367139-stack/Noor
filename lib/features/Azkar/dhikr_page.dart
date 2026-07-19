import 'package:flutter/material.dart';
import 'package:noorah/features/Azkar/adhkar_data.dart';
import 'package:noorah/features/Azkar/dhikr_button.dart';
import 'package:noorah/features/Azkar/dhikr_counter.dart';
import 'package:noorah/features/home/widgets/home_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import '../../core/theme/app_text_styles.dart';

class DhikrPage extends StatefulWidget {
  const DhikrPage({super.key});

  @override
  State<DhikrPage> createState() => _DhikrPageState();
}

class _DhikrPageState extends State<DhikrPage> {
  int counter = 0;
  int current = 0;
  bool isReady = false;

  late SharedPreferences prefs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    current = prefs.getInt('current_dhikr') ?? 0;
    if (current < 0 || current >= adhkar.length) current = 0;
    counter = prefs.getInt("dhikr_$current") ?? 0;

    if (mounted) {
      setState(() {
        isReady = true;
      });
    }
  }

  Future<void> loadCounter() async {
    counter = prefs.getInt("dhikr_$current") ?? 0;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> saveProgress() async {
    await prefs.setInt("dhikr_$current", counter);
    await prefs.setInt('current_dhikr', current);
  }

  Future<void> completeCurrentDhikr() async {
    final completedDhikr = adhkar[current];
    final nextIndex = (current + 1) % adhkar.length;
    final nextDhikr = adhkar[nextIndex];

    await prefs.setInt("dhikr_$current", completedDhikr.target);
    await prefs.setInt("dhikr_$nextIndex", 0);
    await prefs.setInt('current_dhikr', nextIndex);

    if (!mounted) return;

    setState(() {
      current = nextIndex;
      counter = 0;
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (sheetContext) {
        return SizedBox(
          height: 270,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 72,
                ),
                const SizedBox(height: 18),
                Text(
                  "ما شاء الله",
                  style: AppTextStyles.heading1.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "اكتملت ${completedDhikr.target} مرة. الذكر التالي:",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: .7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  nextDhikr.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text("ابدأ الذكر التالي"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> incrementCounter() async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator) {
      Vibration.vibrate(duration: 40);
    }

    final dhikr = adhkar[current];

    if (counter + 1 >= dhikr.target) {
      setState(() {
        counter = dhikr.target;
      });
      await completeCurrentDhikr();
      return;
    }

    setState(() {
      counter++;
    });

    await saveProgress();
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  // Future<void> loadCunter() async {
  //   prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     counter = prefs.getInt('counter') ?? 0;
  //     current = prefs.getInt('current') ?? 0;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final dhikr = adhkar[current];

    return Scaffold(
      bottomNavigationBar: const HomeBottomNavigation(currentIndex: 2),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Dhikr"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButton<int>(
              value: current,
              isExpanded: true,
              dropdownColor: Theme.of(context).cardColor,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              items: List.generate(
                adhkar.length,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text(adhkar[index].title),
                ),
              ),
              onChanged: (value) async {
                if (value == null) return;
                current = value;
                await prefs.setInt('current_dhikr', current);
                await loadCounter();
              },
            ),
            const SizedBox(height: 50),

            Text(
              dhikr.title,
              style: AppTextStyles.heading1.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 30),

            // DhikrCounter(
            //   count: counter,
            //   target: dhikr.target,
            // ),
            DhikrCounter(count: counter, target: dhikr.target),

            const SizedBox(height: 15),

            Text(
              "${((counter / dhikr.target) * 100).clamp(0, 100).toStringAsFixed(0)}%",
              style: AppTextStyles.heading3.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: DhikrButton(onTap: incrementCounter),
            ),

            const SizedBox(height: 15),

            OutlinedButton(
              onPressed: () async {
                setState(() {
                  counter = 0;
                });

                await saveProgress();
              },
              child: const Text("إعادة"),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
