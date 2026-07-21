import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/core/constants/language_provider.dart';
import 'package:noorah/l10n/app_localizations.dart';

class LanguagePage extends ConsumerStatefulWidget {
  const LanguagePage({super.key});

  @override
  ConsumerState<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(languageProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.language,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: RadioGroup<String>(
          groupValue: locale.languageCode,
          onChanged: (value) {
            if (value == null) return;
            ref.read(languageProvider.notifier).changeLanguage(value);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: locale.languageCode == 'ar'
                        ? AppColors.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: const RadioListTile<String>(
                  value: 'ar',
                  title: Text('العربية'),
                  activeColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: locale.languageCode == 'en'
                        ? AppColors.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: const RadioListTile<String>(
                  value: 'en',
                  title: Text('English'),
                  activeColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}