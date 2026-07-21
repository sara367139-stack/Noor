import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noorah/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import 'surah_details_model.dart';
import 'surah_details_page.dart';


class ContinueReadingCard extends StatefulWidget {
  const ContinueReadingCard({super.key});

  @override
  State<ContinueReadingCard> createState() =>
      _ContinueReadingCardState();
}


class _ContinueReadingCardState
    extends State<ContinueReadingCard> {

  String surahName = "Al-Fatihah";
  int surahNumber = 1;


  @override
  void initState() {
    super.initState();
    loadLastRead();
  }


  Future<void> loadLastRead() async {

    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {

      surahName =
          prefs.getString("last_surah_name")
          ?? "Al-Fatihah";


      surahNumber =
          prefs.getInt("last_surah_number")
          ?? 1;

    });
  }



Future<SurahDetailsModel> loadSurah(int number) async {

  final fileName = number.toString();

  final jsonString =
      await rootBundle.loadString(
        "assets/quran/surah/surah_$fileName.json",
      );


  final jsonData = json.decode(jsonString);


  return SurahDetailsModel.fromJson(
    jsonData,
  );
}



  @override
  Widget build(BuildContext context) {

    final lang =
        AppLocalizations.of(context)!;


    return InkWell(

      borderRadius:
          BorderRadius.circular(
            AppRadius.lg,
          ),


      onTap: () async {


        final details =
            await loadSurah(
              surahNumber,
            );


        if (!mounted) return;


        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) =>
                SurahDetailsPage(
                  surah: details,
                ),

          ),

        );


      },


      child: Container(

        width: double.infinity,


        margin:
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),


        padding:
            const EdgeInsets.all(
              AppSpacing.lg,
            ),



        decoration: BoxDecoration(

          color:
              AppColors.primary,


          borderRadius:
              BorderRadius.circular(
                AppRadius.lg,
              ),

        ),



        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [


            Text(

              lang.continueReading,

              style:
                  AppTextStyles.bodySmall
                      .copyWith(

                color:
                    Theme.of(context)
                        .colorScheme
                        .onPrimary,

              ),

            ),



            const SizedBox(
              height: 12,
            ),



            Text(

              surahName,


              style:
                  AppTextStyles.heading2
                      .copyWith(

                color:
                    Theme.of(context)
                        .colorScheme
                        .onPrimary,

              ),

            ),



            const SizedBox(
              height: 6,
            ),



            Text(

              "${lang.surah} $surahNumber",


              style:
                  AppTextStyles.bodyMedium
                      .copyWith(

                color:
                    Theme.of(context)
                        .colorScheme
                        .onPrimary,

              ),

            ),


          ],

        ),

      ),

    );

  }

}