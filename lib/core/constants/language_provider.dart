import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final languageProvider =
    StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('ar')) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    final languageCode = prefs.getString('language');

    if (languageCode != null) {
      state = Locale(languageCode);
    }
  }

  Future<void> changeLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('language', code);

    state = Locale(code);
  }
}