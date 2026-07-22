import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noorah/core/constants/app_strings.dart';
import 'package:noorah/l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.about} ${AppStrings.appName}'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              AppStrings.appName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(l10n.appTagline, textAlign: TextAlign.center),
            const SizedBox(height: 30),
            Text(l10n.versionNumber),
          ],
        ),
      ),
    );
  }
}
