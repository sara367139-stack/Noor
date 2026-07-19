import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_spacing.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  int selectedRate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/profile');
            }
          },
        ),
        title: const Text(
          "Rate Noorah",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Text(
              "Enjoying Noorah?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Your feedback helps us improve your daily Islamic journey.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: AppSpacing.lg),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(5, (index) {
                final starIndex = index + 1;

                return IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRate = starIndex;
                    });
                  },

                  icon: Icon(
                    starIndex <= selectedRate ? Icons.star : Icons.star_border,

                    size: 40,

                    color: starIndex <= selectedRate
                        ? Colors.amber
                        : Colors.grey,
                  ),
                );
              }),
            ),

            const SizedBox(height: AppSpacing.lg),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                onPressed: selectedRate == 0
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Thank you for your rating 🤍"),
                          ),
                        );
                      },

                child: const Text(
                  "Submit Rating",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
