import 'package:flutter/material.dart';
import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_radius.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/core/theme/app_text_styles.dart';
import 'package:noorah/features/quran/widgets/favorite_service.dart';
import 'package:noorah/features/quran/widgets/quran_service.dart';
import 'package:noorah/features/quran/widgets/surah_details_model.dart';
import 'package:noorah/features/quran/widgets/surah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahDetailsPage extends StatefulWidget {
  final SurahModel surah;

  const SurahDetailsPage({super.key, required this.surah});


class _SurahDetailsPageState extends State<SurahDetailsPage> {
  final QuranService _service = QuranService();

  final FavoriteService favoriteService = FavoriteService();
  bool isFavorite = false;
  late Future<SurahDetailsModel> surahFuture;

  Future<void> saveLastRead() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt("last_surah_number", widget.surah.number);

    await prefs.setString("last_surah_name", widget.surah.arabicName);
  }

  Future<void> loadFavorite() async {
    final fav = await favoriteService.isFavorite(widget.surah.number);

    if (!mounted) return;

    setState(() {
      isFavorite = fav;
    });
  }

  @override
  void initState() {
    super.initState();

    surahFuture = _service.loadSurah(widget.surah.number);
    saveLastRead();
    loadFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.surah.englishName),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Remove favorite' : 'Add favorite',
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () async {
              await favoriteService.toggleFavorite(widget.surah.number);

              await loadFavorite();
            },
          ),
        ],
      ),
      body: FutureBuilder<SurahDetailsModel>(
        future: surahFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final surah = snapshot.data!;
          final verses = surah.verses.entries.toList();

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            itemCount: verses.length + 1,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _SurahReaderHeader(
                  surahName: surah.name,
                  englishName: widget.surah.englishName,
                  revelationType: widget.surah.revelationType,
                  versesCount: surah.count,
                );
              }

              final verseEntry = verses[index - 1];

              return _AyahCard(
                ayahNumber: verseEntry.key,
                text: verseEntry.value,
                isLast: index == verses.length,
              );
            },
          );
        },
      ),
    );
  }
}

class _SurahReaderHeader extends StatelessWidget {
  final String surahName;
  final String englishName;
  final String revelationType;
  final int versesCount;

  const _SurahReaderHeader({
    required this.surahName,
    required this.englishName,
    required this.revelationType,
    required this.versesCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: .2),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: colorScheme.onPrimary.withValues(alpha: .9),
            size: 34,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            surahName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            englishName,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading3.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _ReaderChip(label: '$versesCount Ayahs'),
              _ReaderChip(label: revelationType),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Read with calm, clear spacing',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onPrimary.withValues(alpha: .78),
            ),






          // Verses


          ...List.generate(

            verses.length,


            (index) {


              final verse =
                  verses[index];



              final verseNumber =
                  index + 1;



              return Container(

                margin:
                    const EdgeInsets.only(
                      bottom: 14,
                    ),



                child: Card(

                  elevation: 3,


                  shadowColor:
                      Colors.black
                          // ignore: deprecated_member_use
                          .withOpacity(.15),



                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                          22,
                        ),

                  ),



                  child: Padding(

                    padding:
                        const EdgeInsets.all(
                          20,
                        ),



                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.end,



                      children: [



                        Text(

                          verse.value,


                          textAlign:
                              TextAlign.right,



                         style: GoogleFonts.amiri(
  fontSize: 25,
  height: 2,
  color: Theme.of(context)
      .colorScheme
      .onSurface,
),

                        ),





                        const SizedBox(
                          height: 16,
                        ),





                        Align(

                          alignment:
                              Alignment.centerLeft,


                          child: Container(

                            width: 40,

                            height: 40,


                            decoration:
                                BoxDecoration(

                              shape:
                                  BoxShape.circle,


                              color:
                                  AppColors.primary,

                            ),



                            child: Center(

                              child: Text(

                                verseNumber
                                    .toString(),



                                style:
                                    const TextStyle(

                                  color:
                                      Colors.white,


                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),

                            ),

                          ),

                        ),



                      ],

                    ),

                  ),

                ),

              );

            },

          ),



        ],
      ),
    );
  }
}

class _AyahCard extends StatelessWidget {
  final String ayahNumber;
  final String text;
  final bool isLast;

  const _AyahCard({
    required this.ayahNumber,
    required this.text,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.primary.withValues(alpha: .12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  ayahNumber,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  isLast ? 'Final ayah' : 'Ayah $ayahNumber',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: .62),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(Icons.bookmark_border_rounded, color: colorScheme.primary),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          LayoutBuilder(
            builder: (context, constraints) {
              final fontSize = constraints.maxWidth < 340 ? 25.0 : 29.0;

              return Text(
                '$text \u06dd',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: fontSize,
                  height: 2.15,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ReaderChip extends StatelessWidget {
  final String label;

  const _ReaderChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .16),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
