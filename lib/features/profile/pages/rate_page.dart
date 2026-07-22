import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/core/constants/app_strings.dart';
import 'package:noorah/l10n/app_localizations.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  int selectedRate = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
        title: Text(
          l10n.ratePageTitle.replaceAll('AL Noor', AppStrings.appName),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              l10n.enjoyingApp.replaceAll('AL Noor', AppStrings.appName),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              l10n.feedbackHelp,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
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
                          SnackBar(
                            content: Text(l10n.thankYouRating),
                          ),
                        );
                      },

                child: Text(
                  l10n.submitRating,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
