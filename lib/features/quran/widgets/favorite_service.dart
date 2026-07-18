import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String key = "favorite_surahs";

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs
            .getStringList(key)
            ?.map(int.parse)
            .toList() ??
        [];
  }

  Future<bool> isFavorite(int number) async {
    final list = await getFavorites();
    return list.contains(number);
  }

  Future<void> toggleFavorite(int number) async {
    final prefs = await SharedPreferences.getInstance();

    final list = await getFavorites();

    if (list.contains(number)) {
      list.remove(number);
    } else {
      list.add(number);
    }

    await prefs.setStringList(
      key,
      list.map((e) => e.toString()).toList(),
    );
  }
}