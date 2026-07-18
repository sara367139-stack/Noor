import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const String _key = "theme_mode";

  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.system;
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_key);

    if (value == "dark") {
      state = ThemeMode.dark;
    } else if (value == "light") {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.system;
    }
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      await prefs.setString(_key, "light");
    } else {
      state = ThemeMode.dark;
      await prefs.setString(_key, "dark");
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;

    final prefs = await SharedPreferences.getInstance();

    if (mode == ThemeMode.dark) {
      await prefs.setString(_key, "dark");
    } else if (mode == ThemeMode.light) {
      await prefs.setString(_key, "light");
    } else {
      await prefs.remove(_key);
    }
  }
}