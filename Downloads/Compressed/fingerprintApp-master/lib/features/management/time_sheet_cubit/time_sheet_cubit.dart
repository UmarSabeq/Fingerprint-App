import 'package:bloc/bloc.dart';
import 'package:fingerprint/model/reort_model.dart';
import 'package:fingerprint/features/management/repositories/timesheet_repositories.dart';

import 'time_sheet_state.dart';

class TimeSheetCubit extends Cubit<TimeSheetState> {
  TimeSheetCubit({required this.timeSheetRepository})
      : super(TimeSheetInitial());
  final TimeSheetRepository timeSheetRepository;
  getTimeSheetData({
    String m = "0",
    String y = "0",
    String d = "0",
  }) async {
    emit(TimeSheetLogin());
    try {
      ReportModel reportModel =
          await timeSheetRepository.getReport(m: m, y: y, d: d);
      emit(TimeSheetSucces(reportModel));
    } catch (e) {
      emit(TimeSheetError(e.toString()));
    }
  }
}
