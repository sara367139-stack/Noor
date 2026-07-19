import 'package:flutter/material.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/core/theme/app_text_styles.dart';
import 'package:noorah/features/home/widgets/home_bottom_navigation.dart';
import 'package:noorah/features/quran/widgets/continue_reading_card.dart';
import 'package:noorah/features/quran/widgets/quran_app_bar.dart';
import 'package:noorah/features/quran/widgets/search_surah.dart';
import 'package:noorah/features/quran/widgets/surah_list_widget.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavigation(currentIndex: 1),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const QuranAppBar(),
            const ContinueReadingCard(),
            const SearchSurah(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Text(
                    "All Surahs",
                    style: AppTextStyles.heading2.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.sort_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            const Expanded(child: SurahListWidget()),
          ],
        ),
      ),
    );
  }
}
