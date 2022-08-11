import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/constant/apis.dart';
import '../../../data/remote/dio_helper.dart';

class CheckTokenRepositiry {
  final DioHelper dio;

  CheckTokenRepositiry({required this.dio});
  Future<Response> checkToken() async {
    try {
      final Response response = await dio.postData(
        needAuth: true,
        url: FingerPrint.checkToken,
        data: {},
      );

      return response;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
