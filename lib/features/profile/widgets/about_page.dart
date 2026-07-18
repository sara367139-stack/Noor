import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Noorah"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.menu_book,
              size: 90,
            ),
            SizedBox(height: 20),
            Text(
              "Noorah",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Your Daily Islamic Companion",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              "Version 1.0.0",
            ),
          ],
        ),
      ),
    );
  }
}