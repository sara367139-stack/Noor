import 'dart:convert';

import 'package:flutter/services.dart';
// import 'package:noorah/features/quran/widgets/quran_model.dart';
import 'package:noorah/features/quran/widgets/surah_details_model.dart';


class QuranService {
  Future<SurahDetailsModel> loadSurah(int number) async {
    final data = await rootBundle.loadString(
      'assets/quran/surah/surah_$number.json',
    );

    final jsonResult = json.decode(data);

    return SurahDetailsModel.fromJson(jsonResult);
  }
}