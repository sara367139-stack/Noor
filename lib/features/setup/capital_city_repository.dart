import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:noorah/features/setup/capital_city.dart';

class CapitalCityRepository {
  CapitalCityRepository({FirebaseFirestore? firestore, Dio? dio})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _dio = dio ?? Dio();

  final FirebaseFirestore _firestore;
  final Dio _dio;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('capital_cities');

  Future<List<CapitalCity>> getCapitalCities() async {
    try {
      final snapshot = await _collection.orderBy('city').get();
      final cities = snapshot.docs
          .map((doc) => CapitalCity.fromJson(doc.data()))
          .where((city) => city.city.isNotEmpty && city.country.isNotEmpty)
          .toList();

      if (cities.length >= fallbackCapitalCities.length) {
        return cities;
      }
    } catch (_) {
      // Firebase can be unavailable during first launch or local development.
    }

    try {
      final cities = await _fetchCapitalCities();
      await _cacheCapitalCities(cities);
      return cities;
    } catch (_) {
      return [...fallbackCapitalCities]..sort(_sortByDisplayName);
    }
  }

  Future<CapitalCity> findByDisplayName(String displayName) async {
    final normalized = displayName.trim().toLowerCase();
    final cities = await getCapitalCities();

    return cities.firstWhere(
      (city) => city.displayName.toLowerCase() == normalized,
      orElse: () => cities.firstWhere(
        (city) =>
            city.city.toLowerCase() == normalized ||
            city.country.toLowerCase() == normalized,
        orElse: () => fallbackCapitalCities.first,
      ),
    );
  }

  Future<List<CapitalCity>> _fetchCapitalCities() async {
    final response = await _dio.get<List<dynamic>>(
      'https://restcountries.com/v3.1/all',
      queryParameters: {'fields': 'name,capital,latlng,cca2'},
    );

    final rawCountries = response.data ?? [];
    final cities = <CapitalCity>[];

    for (final rawCountry in rawCountries) {
      if (rawCountry is! Map<String, dynamic>) continue;

      final capitals = rawCountry['capital'];
      final latLng = rawCountry['latlng'];
      final name = rawCountry['name'];

      if (capitals is! List || capitals.isEmpty) continue;
      if (latLng is! List || latLng.length < 2) continue;
      if (name is! Map<String, dynamic>) continue;

      final city = capitals.first?.toString().trim() ?? '';
      final commonName = name['common']?.toString().trim() ?? '';
      final countryCode = rawCountry['cca2']?.toString().trim() ?? '';
      final latitude = (latLng[0] as num?)?.toDouble();
      final longitude = (latLng[1] as num?)?.toDouble();

      if (city.isEmpty ||
          commonName.isEmpty ||
          countryCode.isEmpty ||
          latitude == null ||
          longitude == null) {
        continue;
      }

      cities.add(
        CapitalCity(
          city: city,
          country: commonName,
          countryCode: countryCode,
          latitude: latitude,
          longitude: longitude,
        ),
      );
    }

    return cities..sort(_sortByDisplayName);
  }

  Future<void> _cacheCapitalCities(List<CapitalCity> cities) async {
    try {
      final batch = _firestore.batch();

      for (final city in cities) {
        final id = '${city.countryCode}_${city.city}'.toLowerCase().replaceAll(
          RegExp(r'[^a-z0-9]+'),
          '_',
        );
        batch.set(_collection.doc(id), city.toJson());
      }

      await batch.commit();
    } catch (_) {
      // Searching should still work if Firestore rules reject writes.
    }
  }

  int _sortByDisplayName(CapitalCity a, CapitalCity b) {
    return a.displayName.compareTo(b.displayName);
  }
}
