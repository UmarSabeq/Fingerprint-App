import 'package:dio/dio.dart';
import 'package:fingerprint/data/local/hiva_helper.dart';

class DioHelper {
  final Dio dio;
  final HiveHelper hiveHelper;

  DioHelper({
    required this.dio,
    required this.hiveHelper,
  });

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    required bool needAuth,
  }) {
    if (needAuth) {
      final String? token = hiveHelper.getData("token");
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return dio.get(
      url,
      queryParameters: query,
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    required bool needAuth,
  }) {
    if (needAuth) {
      final String? token = hiveHelper.getData("token");
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return dio.post(
      url,
      data: data,
      options: Options(
        responseType: ResponseType.plain,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );
  }
}
