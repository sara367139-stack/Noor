import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/core/constants/app_strings.dart';


import 'package:noorah/core/constants/language_provider.dart';
import 'package:noorah/l10n/app_localizations.dart';

import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_provider.dart';

class NoorahApp extends ConsumerWidget {
  const NoorahApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final locale = ref.watch(languageProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      locale: locale,

      supportedLocales: AppLocalizations.supportedLocales,

      localizationsDelegates:
          AppLocalizations.localizationsDelegates,

      routerConfig: appRouter,
    );
  }
}