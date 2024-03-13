import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://www.bazoka.eraasoft.com/api',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token',
    };
    return dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String lang = 'ar',
      String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData(
      {required String url, String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    };
    return await dio!.delete(url);
  }
}
