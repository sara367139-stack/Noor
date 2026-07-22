import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:noorah/features/home/widgets/prayer_model.dart';
import 'package:noorah/features/setup/capital_city.dart';

class PrayerService {
  PrayerService({Dio? dio, FirebaseFirestore? firestore})
    : dio = dio ?? Dio(),
      firestore = firestore ?? FirebaseFirestore.instance;

  final Dio dio;
  final FirebaseFirestore firestore;

  Future<PrayerModel> getPrayerTimes({required CapitalCity location}) async {
    final today = DateTime.now();
    final date = "${today.day}-${today.month}-${today.year}";
    final cacheId = '${location.countryCode}_$date'.toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]+'),
      '_',
    );

    try {
      final cached = await firestore
          .collection('country_prayer_times')
          .doc(cacheId)
          .get();
      final cachedTimings = cached.data()?['timings'];

      if (cached.exists && cachedTimings is Map<String, dynamic>) {
        return PrayerModel.fromJson(cachedTimings);
      }
    } catch (_) {
      // Prayer times can still be loaded from the API without the cache.
    }

    final response = await dio.get(
      "https://api.aladhan.com/v1/timings/$date",
      queryParameters: {
        "latitude": location.latitude,
        "longitude": location.longitude,
        "method": 5,
      },
    );

    final timings = Map<String, dynamic>.from(
      response.data["data"]["timings"] as Map,
    );

    try {
      await firestore.collection('country_prayer_times').doc(cacheId).set({
        'city': location.city,
        'country': location.country,
        'countryCode': location.countryCode,
        'date': date,
        'latitude': location.latitude,
        'longitude': location.longitude,
        'timings': timings,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Firestore cache failures should not block prayer-time display.
    }

    return PrayerModel.fromJson(timings);
  }
}
