import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerprint/data/remote/dio_helper.dart';

import '../../../core/constant/apis.dart';
import '../../../model/report_summary_model.dart';

class ReportSummaryReosiorie {
  final DioHelper dio;

  ReportSummaryReosiorie({required this.dio});
  Future<ReportSummaryModel> getReportSummary({
    String m = "0",
    String y = "0",
  }) async {
    try {
      final Response response = await dio.getData(
          url: FingerPrint.reportSummary + "?year=$y&month=$m", needAuth: true);
      final data = json.decode(response.data) as Map<String, dynamic>;
      final ReportSummaryModel reportModel = ReportSummaryModel.fromMap(data);
      return reportModel;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error["error"];
    } catch (error) {
      throw "..Oops $error";
    }
  }
}
