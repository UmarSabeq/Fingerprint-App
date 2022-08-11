import 'package:equatable/equatable.dart';
import 'package:fingerprint/model/reort_model.dart';

class TimeSheetState extends Equatable {
  const TimeSheetState();
  @override
  List<Object> get props => [];
}

class TimeSheetInitial extends TimeSheetState {}

class TimeSheetLogin extends TimeSheetState {}

class TimeSheetSucces extends TimeSheetState {
  final ReportModel reportModel;
  const TimeSheetSucces(this.reportModel);
  @override
  List<Object> get props => [reportModel];
}

class TimeSheetError extends TimeSheetState {
  final String massage;

  const TimeSheetError(this.massage);

  @override
  List<Object> get props => [massage];
}
