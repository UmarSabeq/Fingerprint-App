import 'package:bloc/bloc.dart';
import 'package:fingerprint/features/report_summary/report_summary_cubit/report_summary_state.dart';

import '../../../model/report_summary_model.dart';
import '../reposiories/report_summary_reosiorie.dart';

class ReportSummaryCubit extends Cubit<ReportSummaryState> {
  ReportSummaryCubit({required this.reportSummaryReosiorie})
      : super(ReportSummaryInitial());
  final ReportSummaryReosiorie reportSummaryReosiorie;
  getReportSummary({
    String m = "0",
    String y = "0",
  }) async {
    emit(ReportSummaryLoading());
    try {
      ReportSummaryModel reportModel =
          await reportSummaryReosiorie.getReportSummary(
        m: m,
        y: y,
      );
      emit(ReportSummarySucces(reportModel));
    } catch (e) {
      emit(ReportSummaryError(e.toString()));
    }
  }
}
