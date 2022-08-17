import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'http://newsapi.org/',
        receiveDataWhenStatusError: true,
        // headers: {
        //   'Content-Type': 'application/json',
        // }
        ));
    // dio!.options.connectTimeout = 5000;
    // dio!.options.receiveTimeout = 3000;
    // return dio;
  }

  static Future<Response?> getData({
    required String url,
    required Map<String, dynamic> query,
    // String lang = 'ar',
    // String? token,
  }) async {
    // dio.options.headers = {
    //   'lang': lang,
    //   'Authorization': token,
    // };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
