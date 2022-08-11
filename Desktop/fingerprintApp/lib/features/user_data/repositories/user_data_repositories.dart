import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerprint/data/remote/dio_helper.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/apis.dart';
import '../../../data/local/hiva_helper.dart';
import '../../../model/userdata_model.dart';
import '../../auth/view/login.dart';

class UserDataRepositories {
  final DioHelper dio;
  UserDataRepositories({required this.dio});
  Future<UserDataModel> getUserData() async {
    try {
      final Response response =
          await dio.getData(url: FingerPrint.userData, needAuth: true);
      final dataReort = json.decode(response.data) as Map<String, dynamic>;
      final UserDataModel reportModel = UserDataModel.fromMap(dataReort);
      return reportModel;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }

  Future<Response> checkToken() async {
    try {
      final Response response = await dio.postData(
        needAuth: true,
        url: FingerPrint.checkToken,
        data: {},
      );
      // if (response.statusCode == 500) {
      //   print("ssssssssssssssssssssssssssssssssssssssssss");
      //   HiveHelper().removeData("token");
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute<void>(
      //         builder: (BuildContext context) => const Signin()),
      //     (route) => false,
      //   );
      // }
      return response;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
