import 'package:flutter/material.dart';
import 'package:noorah/features/Azkar/pages/adhkar_data.dart';
import 'package:noorah/l10n/app_localizations.dart';

class MorningAdhkarPage extends StatefulWidget {
  const MorningAdhkarPage({super.key});

  @override
  State<MorningAdhkarPage> createState() => _MorningAdhkarPageState();
}

class _MorningAdhkarPageState extends State<MorningAdhkarPage> {
  late List<Map<String, dynamic>> adhkar;
 
@override
void initState() {
  super.initState();

  adhkar = morningAdhkar
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
}

  @override
Widget build(BuildContext context) {
  final completed = adhkar.where((e) => e["count"] == 0).length;
 final lang = AppLocalizations.of(context)!;
  return Scaffold(
    appBar: AppBar(
    title: Text(lang.morningAdhkar),
      centerTitle: true,
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: completed / adhkar.length,
                minHeight: 10,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 8),
              Text(
               "$completed / ${adhkar.length} ${lang.completed}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: adhkar.length,
            itemBuilder: (context, index) {
              final item = adhkar[index];
              final finished = item["count"] == 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Card(
                  elevation: 6,
                  color: finished ? const Color.fromARGB(255, 170, 182, 171) : null,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        Text(
                          item["title"],
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          item["text"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            height: 2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: finished
                                ? null
                                : () {
                                    setState(() {
                                      item["count"]--;
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: finished
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              finished
                                  ?"✓ ${lang.completed}"
                                  : "${lang.remaining} : ${item["count"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}