// features/quran/data/repo/quran_repo.dart
import 'package:dio/dio.dart';
import 'package:islami/core/services/dio_endpoints.dart';
import 'package:islami/core/services/dio_provider.dart';
import '../models/response/quran_details/quran_details.dart';

class QuranRepo {
  static Future<QuranDetails?> loadQuran() async {
    try {
      var response = await DioProvider.get(endpoint: DioEndPoints.quranbaseUrl);
      if (response.statusCode == 200) {
        print(QuranDetails(data: response.data));
        return QuranDetails.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
