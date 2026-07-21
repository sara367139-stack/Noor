import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdhkarPage extends StatelessWidget {
  const AdhkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adhkar = [
      "سبحان الله",
      "الحمد لله",
      "الله أكبر",
      "لا إله إلا الله",
      "لا حول ولا قوة إلا بالله",
      "أستغفر الله",
      "اللهم صل وسلم على نبينا محمد",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("الأذكار"), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: adhkar.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              leading: const Icon(Icons.auto_awesome, color: Colors.green),
              title: Text(
                adhkar[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                context.push("/dhikr");
              },
            ),
          );
        },
      ),
    );
  }
}