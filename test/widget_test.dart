import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noorah/features/home/widgets/home_bottom_navigation.dart';
import 'package:noorah/features/quran/widgets/quran_app_bar.dart';
import 'package:noorah/l10n/app_localizations.dart';

void main() {
  testWidgets('home bottom navigation uses Arabic labels for Arabic locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const Scaffold(body: HomeBottomNavigation(currentIndex: 0)),
      ),
    );

    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('القرآن'), findsOneWidget);
    expect(find.text('الأذكار'), findsOneWidget);
    expect(find.text('الإعدادات'), findsOneWidget);
  });

  testWidgets('quran app bar uses Arabic title for Arabic locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const Scaffold(body: QuranAppBar()),
      ),
    );

    expect(find.text('القرآن'), findsOneWidget);
  });
}
