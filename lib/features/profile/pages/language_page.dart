import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:noorah/core/constants/app_colors.dart';
import 'package:noorah/core/constants/app_spacing.dart';
import 'package:noorah/core/constants/language_provider.dart';
import 'package:noorah/l10n/app_localizations.dart';

class LanguagePage extends ConsumerStatefulWidget {
  const LanguagePage({super.key});

  @override
  ConsumerState<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<LanguagePage> {

  String selectedCode = 'ar';
  bool hasUserChangedSelection = false;

  final languages = const [
    _LanguageOption(
      code: 'ar',
      label: 'العربية',
    ),
    _LanguageOption(
      code: 'en',
      label: 'English',
    ),
  ];


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!hasUserChangedSelection) {
      selectedCode =
          ref.read(languageProvider).languageCode;
    }
  }


  Future<void> _confirmLanguage() async {

    await ref
        .read(languageProvider.notifier)
        .changeLanguage(selectedCode);


    if (!mounted) return;


    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/profile');
    }
  }



  @override
  Widget build(BuildContext context) {

    ref.watch(languageProvider);

    final l10n = AppLocalizations.of(context)!;


    return Scaffold(

      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,


      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),

          onPressed: () {

            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/profile');
            }

          },
        ),


        title: Text(
          l10n.language,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),


        centerTitle: true,
      ),



      body: Padding(

        padding:
            const EdgeInsets.all(AppSpacing.lg),


        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [


            Text(
              l10n.chooseYourLanguage,

              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),



            const SizedBox(
              height: AppSpacing.md,
            ),



            ...languages.map(

              (language) => Card(

                elevation: 0,


                margin:
                    const EdgeInsets.only(bottom: 12),



                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(16),


                  side: BorderSide(

                    color:
                        selectedCode == language.code

                            ? AppColors.primary

                            : Colors.grey.shade300,

                  ),
                ),



                child: ListTile(


                  onTap: () {

                    setState(() {

                      selectedCode =
                          language.code;

                      hasUserChangedSelection =
                          true;

                    });

                  },



                  title: Text(

                    language.label,

                    style: TextStyle(

                      fontSize: 16,

                      fontWeight:
                          FontWeight.w600,


                      color:
                          Theme.of(context)
                              .colorScheme
                              .onSurface,

                    ),
                  ),



                  trailing: Icon(

                    selectedCode == language.code

                        ? Icons.check_circle_rounded

                        : Icons.circle_outlined,



                    color:

                        selectedCode == language.code

                            ? AppColors.primary

                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: .42),

                  ),

                ),
              ),
            ),



            const Spacer(),




            SizedBox(

              width: double.infinity,


              child: FilledButton.icon(

                onPressed:
                    _confirmLanguage,


                icon:
                    const Icon(Icons.check_rounded),



                label:
                    Text(l10n.confirm),

              ),
            ),


          ],
        ),
      ),
    );
  }
}



class _LanguageOption {

  final String code;
  final String label;


  const _LanguageOption({

    required this.code,
    required this.label,

  });

}