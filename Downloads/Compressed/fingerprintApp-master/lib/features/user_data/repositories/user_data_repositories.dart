import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerprint/data/remote/dio_helper.dart';

import '../../../core/constant/apis.dart';
import '../../../data/local/hiva_helper.dart';
import '../../../model/userdata_model.dart';

class UserDataRepositories {
  final DioHelper dio;
  final HiveHelper hiveHelper;
  UserDataRepositories({required this.dio, required this.hiveHelper});
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
}
