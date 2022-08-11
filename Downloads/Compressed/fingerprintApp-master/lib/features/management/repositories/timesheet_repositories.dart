import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerprint/core/constant/apis.dart';
import 'package:fingerprint/data/remote/dio_helper.dart';
import 'package:fingerprint/model/reort_model.dart';

class TimeSheetRepository {
  final DioHelper dio;
  TimeSheetRepository({required this.dio});
  Future<ReportModel> getReport({
    String m = "0",
    String y = "0",
    String d = "0",
  }) async {
    try {
      final Response response = await dio.getData(
          url: FingerPrint.timesheet + "?month=$m&year=$y&day=$d",
          needAuth: true);
      final dataReort = json.decode(response.data) as Map<String, dynamic>;
      final ReportModel reportModel = ReportModel.fromMap(dataReort);
      return reportModel;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
