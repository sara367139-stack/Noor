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

 late SharedPreferences prefs;

Future<void> initPrefs() async {
  prefs = await SharedPreferences.getInstance();
  loadCounter();
}

Future<void> loadCounter() async {
  counter = prefs.getInt("dhikr_$current") ?? 0;

  if (mounted) {
    setState(() {});
  }
}

Future<void> saveCounter() async {
  await prefs.setInt("dhikr_$current", counter);
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
    final dhikr = adhkar[current];

    return Scaffold(
       bottomNavigationBar: const HomeBottomNavigation(
        currentIndex: 2,
),  
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
  style: TextStyle(
    color: Theme.of(context).colorScheme.onSurface,
  ),
  items: List.generate(
    adhkar.length,
    (index) => DropdownMenuItem(
      value: index,
      child: Text(adhkar[index].title),
    ),
  ),
  onChanged: (value) async {
    current = value!;
    await loadCounter();
    setState(() {});
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
             DhikrCounter(
     count: counter,
      target: dhikr.target,
     ),

     const SizedBox(height: 15),

     Text(
      "${((counter / dhikr.target) * 100).clamp(0, 100).toStringAsFixed(0)}%",
       style: AppTextStyles.heading3.copyWith(
      color: Theme.of(context).colorScheme.onSurface,
      ),
      ),

     const Spacer(), 

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: DhikrButton(
               onTap: () async {
  // ignore: dead_code
            if (await Vibration.hasVibrator()) {
                Vibration.vibrate(duration: 40);
                     }

                   setState(() {
                 counter++;
                    });
                  await saveCounter();
                  await prefs.setInt('counter', counter);
                  await prefs.setInt('current', current);

                  if (counter == dhikr.target) {
                    if (!mounted) return;
                     // داخل showModalBottomSheet

showModalBottomSheet(
  // ignore: use_build_context_synchronously
  context: context,
  // ignore: use_build_context_synchronously
  backgroundColor: Theme.of(context).cardColor,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25),
    ),
  ),
  builder: (_) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 80,
          ),

          const SizedBox(height: 20),

          Text(
            "ما شاء الله 🎉",
            style: AppTextStyles.heading1.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "لقد أكملت ${dhikr.target} مرة",
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  // ignore: deprecated_member_use
                  .withOpacity(.7),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("متابعة"),
          ),
        ],
      ),
    );
  },
);


                    // showDialog(
                    //   // ignore: use_build_context_synchronously
                    //   context: context,
                    //   builder: (_) => AlertDialog(
                    //     title: const Text("🎉 أحسنت"),
                    //     content: Text(
                    //       "لقد أتممت ${dhikr.target} مرة من\n${dhikr.title}",
                    //     ),
                    //     actions: [
                    //       TextButton(
                    //         onPressed: () => Navigator.pop(context),
                    //         child: const Text("متابعة"),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }
                },
              ),
            ),

            const SizedBox(height: 15),

            OutlinedButton(
              onPressed: () async {
                setState(() {
                  counter = 0;
                });

                 await saveCounter();
                await prefs.setInt('counter', counter);
                await prefs.setInt('current', current);
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