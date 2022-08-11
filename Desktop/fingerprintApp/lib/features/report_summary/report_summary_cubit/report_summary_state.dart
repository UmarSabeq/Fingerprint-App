import 'package:equatable/equatable.dart';

import '../../../model/report_summary_model.dart';

class ReportSummaryState extends Equatable {
  const ReportSummaryState();
  @override
  List<Object> get props => [];
}

class ReportSummaryInitial extends ReportSummaryState {}

class ReportSummaryLoading extends ReportSummaryState {}

class ReportSummarySucces extends ReportSummaryState {
  final ReportSummaryModel reportModel;
  const ReportSummarySucces(this.reportModel);
  @override
  List<Object> get props => [reportModel];
}

class ReportSummaryError extends ReportSummaryState {
  final String massage;

  const ReportSummaryError(this.massage);

  @override
  List<Object> get props => [massage];
}
