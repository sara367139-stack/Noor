import 'package:flutter/material.dart';
import 'package:noorah/features/Azkar/pages/adhkar_data.dart';

class EveningAdhkarPage extends StatefulWidget {
  const EveningAdhkarPage({super.key});

  @override
  State<EveningAdhkarPage> createState() => _EveningAdhkarPageState();
}

class _EveningAdhkarPageState extends State<EveningAdhkarPage> {
 late List<Map<String, dynamic>> adhkar;

@override
void initState() {
  super.initState();

  adhkar = eveningAdhkar
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
}

 @override
Widget build(BuildContext context) {
  final completed = adhkar.where((e) => e["count"] == 0).length;

  return Scaffold(
    appBar: AppBar(
      title: const Text("Evening Adhkar"),
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
                "$completed / ${adhkar.length} Completed",
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
                  shadowColor: Colors.black12,
                  color: finished ? const Color.fromARGB(255, 170, 182, 171) : null,
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
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
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
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              finished
                                  ? "✓ Completed"
                                  : "Remaining : ${item["count"]}",
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