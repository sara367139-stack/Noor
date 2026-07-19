import 'dart:convert';
import 'package:flutter/services.dart';

class DailyAyah {
  final String surahName;
  final String verse;
  final int verseNumber;

  DailyAyah({
    required this.surahName,
    required this.verse,
    required this.verseNumber,
  });
}

class DailyAyahService {
  static Future<DailyAyah> getAyahOfTheDay() async {
    final now = DateTime.now();

    final dayOfYear =
        now.difference(DateTime(now.year, 1, 1)).inDays + 1;

    final surahNumber = (dayOfYear % 114) + 1;

    final jsonString = await rootBundle.loadString(
      'assets/quran/surah/surah_$surahNumber.json',
    );

    final data = json.decode(jsonString);

    final verses = data["verse"] as Map<String, dynamic>;

    final verseIndex =
        (dayOfYear % verses.length) + 1;

    return DailyAyah(
      surahName: data["name"],
      verse: verses["verse_$verseIndex"],
      verseNumber: verseIndex,
    );
  }
}