import 'package:dio/dio.dart';
import 'package:noorah/features/home/widgets/prayer_model.dart';



class PrayerService {

  final Dio dio = Dio();


  Future<PrayerModel> getPrayerTimes() async {

final today = DateTime.now();

final date =
"${today.day}-${today.month}-${today.year}";


final response = await dio.get(
  "https://api.aladhan.com/v1/timings/$date",
  queryParameters: {
    "latitude": 28.8,
    "longitude": 30.8,
    "method": 5,
  },
);


    final timings =
        response.data["data"]["timings"];


    return PrayerModel.fromJson(timings);

  }

}