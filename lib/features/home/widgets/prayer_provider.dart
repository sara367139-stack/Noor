import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noorah/features/home/widgets/prayer_model.dart';
import 'package:noorah/features/home/widgets/prayer_service.dart';


final prayerProvider =
FutureProvider<PrayerModel>((ref) async {

  return PrayerService()
      .getPrayerTimes();

});