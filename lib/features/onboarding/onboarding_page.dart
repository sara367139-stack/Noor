import 'package:flutter/material.dart';
import 'package:noorah/features/onboarding/onboarding_card.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingCard(
        
        icon: Icons.menu_book_rounded,
        title: "Read Quran Anytime",
        description:
            "Read the Holy Quran with beautiful Uthmani font, bookmarks, and continue from your last reading.",
      ),
    );
  }
}