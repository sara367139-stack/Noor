import 'package:flutter/material.dart';
import 'package:noorah/features/quran/widgets/favorite_service.dart';
// import 'package:noorah/core/constants/app_colors.dart';
// import 'package:noorah/features/quran/widgets/ayah_data.dart';
// import 'package:noorah/features/quran/widgets/ayah_tile.dart';
import 'package:noorah/features/quran/widgets/quran_service.dart';
import 'package:noorah/features/quran/widgets/surah_details_model.dart';
import 'package:noorah/features/quran/widgets/surah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SurahDetailsPage extends StatefulWidget {
  final SurahModel surah;

  const SurahDetailsPage({
    super.key,
    required this.surah,
  });

  @override
  State<SurahDetailsPage> createState() => _SurahDetailsPageState();
}

class _SurahDetailsPageState extends State<SurahDetailsPage> {
  final QuranService _service = QuranService();

  final FavoriteService favoriteService = FavoriteService();
bool isFavorite = false; 
  late Future<SurahDetailsModel> surahFuture;

  Future<void> saveLastRead() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt(
    "last_surah_number",
    widget.surah.number,
  );

  await prefs.setString(
    "last_surah_name",
    widget.surah.arabicName,
  );
}
  Future<void> loadFavorite() async {
  final fav =
      await favoriteService.isFavorite(widget.surah.number);

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
  appBar: AppBar(
    title: Text(widget.surah.arabicName),
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(
          isFavorite
              ? Icons.favorite
              : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () async {
          await favoriteService.toggleFavorite(
            widget.surah.number,
          );

          await loadFavorite();
        },
      ),
    ],
  ),

  body: FutureBuilder<SurahDetailsModel>(
    future: surahFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState ==
          ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot.hasError) {
        return Center(
          child: Text(snapshot.error.toString()),
        );
      }

      final surah = snapshot.data!;

      return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            surah.name,
            textAlign: TextAlign.center,
          style: TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: Theme.of(context).colorScheme.onSurface,
),
          ),

          const SizedBox(height: 20),

          ...surah.verses.entries.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "${e.value} ۝",
                textAlign: TextAlign.end,
          style: TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: Theme.of(context).colorScheme.onSurface,
),
              ),
            ),
          ),
        ],
      );
    },
  ),
);
  }
}