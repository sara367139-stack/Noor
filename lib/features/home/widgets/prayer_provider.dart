import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/core/user/user_profile_provider.dart';
import 'package:noorah/features/home/widgets/prayer_model.dart';
import 'package:noorah/features/home/widgets/prayer_service.dart';
import 'package:noorah/features/setup/capital_city_repository.dart';

final prayerProvider = FutureProvider<PrayerModel>((ref) async {
  final userProfile = ref.watch(userProfileProvider);
  final location = await CapitalCityRepository().findByDisplayName(
    userProfile.location,
  );

  return PrayerService().getPrayerTimes(location: location);
});
