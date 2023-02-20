import 'package:dio/dio.dart';
import 'package:rick_and_morty/constatns/strings.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30)));
  }

  static Future<Map<String, dynamic>> getAllCharacters(
      {Map<String, dynamic>? query}) async {
    try {
      var reponse = await dio!.get('character', queryParameters: query);
      return await reponse.data;
    } catch (e) {
      return {};
    }
  }
}
