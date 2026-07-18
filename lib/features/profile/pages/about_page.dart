import 'package:flutter/material.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_spacing.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "About Noorah",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),


      body: SingleChildScrollView(

        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(

          children: [

            CircleAvatar(

              radius: 45,

              backgroundColor: AppColors.primary,

              child: const Icon(
                Icons.auto_stories,
                size: 50,
                color: Colors.white,
              ),

            ),


            const SizedBox(
              height: AppSpacing.md,
            ),


            const Text(
              "Noorah",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(
              height: 8,
            ),


            const Text(
              "Your Daily Islamic Companion",
              style: TextStyle(
                fontSize: 16,
              ),
            ),


            const SizedBox(
              height: AppSpacing.lg,
            ),



            _aboutCard(
              icon: Icons.info_outline,
              title: "About App",
              description:
              "Noorah helps you stay connected with your faith through Quran, Salah, Azkar, and Islamic daily reminders.",
            ),



            _aboutCard(
              icon: Icons.star_outline,
              title: "Features",
              description:
              "• Quran Reader\n• Prayer Times\n• Qibla Direction\n• Daily Azkar\n• Islamic Calendar",
            ),



            _aboutCard(
              icon: Icons.update,
              title: "Version",
              description:
              "Version 1.0.0",
            ),



            _aboutCard(
              icon: Icons.favorite_outline,
              title: "Made With Love",
              description:
              "Created to make your daily worship easier and more organized.",
            ),

          ],
        ),
      ),
    );
  }



  Widget _aboutCard({

    required IconData icon,
    required String title,
    required String description,

  }) {

    return Card(

      elevation: 0,

      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),


      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Row(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Icon(
              icon,
              color: AppColors.primary,
              size: 30,
            ),


            const SizedBox(
              width: 15,
            ),


            Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                  const SizedBox(
                    height: 6,
                  ),


                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}