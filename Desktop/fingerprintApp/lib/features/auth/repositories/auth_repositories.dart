import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fingerprint/data/local/hiva_helper.dart';

import '../../../core/constant/apis.dart';
import '../../../data/remote/dio_helper.dart';

class SigInRepository {
  final DioHelper dio;
  final HiveHelper hiveHelper;

  SigInRepository({
    required this.dio,
    required this.hiveHelper,
  });

  Future<Response> signIn({
    required String phone,
    required String password,
  }) async {
    try {
      final Response response = await dio.postData(
        needAuth: false,
        url: FingerPrint.logIn,
        data: {
          'phone_num': phone,
          'password': password,
        },
      );
      var data = jsonDecode(response.data) as Map<String, dynamic>;
      String token = data['token'];
      // print(token);
      await hiveHelper.putData("token", token);
      await hiveHelper.putData("ftra", data['ftra']);
      // await hiveHelper.putData("phone", data['phone_num']);
      // await hiveHelper.putData("numWork", data['mid']);
      // await hiveHelper.putData("place", data['profession']['title_ar']);

      log(token);
      log(response.statusCode.toString());
      return response;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }

  Future<Response> signUp({
    required String phone,
    required String password,
    required String name,
    required String passwordConfirmation,
  }) async {
    try {
      final Response response = await dio.postData(
        needAuth: false,
        url: FingerPrint.register,
        data: {
          'name': name,
          'phone_num': phone,
          'password': password,
          'password_confirmation': passwordConfirmation
        },
      );
      var data = jsonDecode(response.data) as Map<String, dynamic>;
      String token = data['token'];
      // print(token);
      await hiveHelper.putData("token", token);
      await hiveHelper.putData("name", data['full_name']);
      await hiveHelper.putData("phone", data['phone_num']);
      await hiveHelper.putData("numWork", data['mid']);
      await hiveHelper.putData("place", data['profession']['title_ar']);

      log(token);
      log(response.statusCode.toString());
      return response;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }

  Future<String> forgetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final Response response = await dio.postData(
        needAuth: false,
        url: FingerPrint.forgetPassword,
        data: {
          'phone_num': phone,
          'password': password,
          'password_confirmation': passwordConfirmation
        },
      );
      var data = jsonDecode(response.data) as Map<String, dynamic>;

      return data['msg'];
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }

  // Future<bool> hideFeatures() async {
  //   try {
  //     final Response response = await dio.getData(
  //       needAuth: false,
  //       url: FingerPrint.hideFeatures,
  //     );
  //     var data = jsonDecode(response.data) as Map<String, dynamic>;
  //     await hiveHelper.putData("HF", data['msg']);
  //     return data['msg'];
  //   } on DioError catch (dioError) {
  //     var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
  //     throw error['error'];
  //   } catch (error) {
  //     throw '..Oops $error';
  //   }
  // }

}
