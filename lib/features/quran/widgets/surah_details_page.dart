import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'surah_details_model.dart';

import '../../../../core/constants/app_colors.dart';


class SurahDetailsPage extends StatelessWidget {

  final SurahDetailsModel surah;


  const SurahDetailsPage({
    super.key,
    required this.surah,
  });



  @override
  Widget build(BuildContext context) {


    final verses =
        surah.verses.entries.toList();



    return Scaffold(


      appBar: AppBar(

        title: Text(

          surah.name,

          style: const TextStyle(
            fontFamily: "Amiri",
            fontSize: 24,
          ),

        ),

        centerTitle: true,

      ),



      body: ListView(

        padding:
            const EdgeInsets.all(16),


        children: [



          // Basmala Card

          if (verses.isNotEmpty &&
              verses.first.value.contains("بِسْم"))

            Container(

              margin:
                  const EdgeInsets.only(
                    bottom: 18,
                  ),


              padding:
                  const EdgeInsets.all(20),



              decoration:
                  BoxDecoration(

                color:
                    AppColors.primary
                        // ignore: deprecated_member_use
                        .withOpacity(.12),


                borderRadius:
                    BorderRadius.circular(22),

              ),



              child: Center(

                child: Text(

                  "﷽",

                 style: GoogleFonts.amiri(
  fontSize: 38,
),

                ),

              ),

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