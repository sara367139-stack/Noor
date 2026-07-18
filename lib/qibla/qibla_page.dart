import 'package:flutter/material.dart';

class QiblaPage extends StatelessWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qibla"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.explore,
              size: 120,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 30),

            Text(
              "Qibla Compass",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 10),

            Text(
              "Coming Soon...",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}