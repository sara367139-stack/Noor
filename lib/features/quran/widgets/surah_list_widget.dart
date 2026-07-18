import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/features/home/widgets/search_provider.dart';
import 'package:noorah/features/quran/widgets/surah_data.dart';


import 'surah_tile.dart';

class SurahListWidget extends ConsumerWidget {
  const SurahListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

    final filteredSurahs = surahs.where((surah) {
      return surah.englishName
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          surah.arabicName.contains(query);
    }).toList();

    return ListView.builder(
      itemCount: filteredSurahs.length,
      itemBuilder: (context, index) {
        return SurahTile(
          surah: filteredSurahs[index],
        );
      },
    );
  }
}