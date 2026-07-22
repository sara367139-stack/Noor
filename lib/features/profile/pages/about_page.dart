import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/core/constants/app_strings.dart';
import 'package:noorah/l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
          '${l10n.about} ${AppStrings.appName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),

        child: Column(
          children: [
            Text(
              AppStrings.appName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              l10n.appTagline,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: AppSpacing.lg),

            _aboutCard(
              icon: Icons.info_outline,
              title: l10n.aboutApp,
              description: l10n.aboutAppDescription,
            ),

            _aboutCard(
              icon: Icons.star_outline,
              title: l10n.features,
              description: l10n.featuresList,
            ),

            _aboutCard(
              icon: Icons.update,
              title: l10n.version,
              description: l10n.versionNumber,
            ),

            _aboutCard(
              icon: Icons.favorite_outline,
              title: l10n.madeWithLove,
              description: l10n.madeWithLoveDescription,
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

      margin: const EdgeInsets.only(bottom: 15),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Icon(icon, color: AppColors.primary, size: 30),

            const SizedBox(width: 15),

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

                  const SizedBox(height: 6),

                  Text(description, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
