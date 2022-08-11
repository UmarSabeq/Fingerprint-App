import 'package:fingerprint/features/report_summary/report_summary_cubit/report_summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../management/widget/filter_dialog.dart';
import '../report_summary_cubit/report_summary_cubit.dart';
import '../widget/card_tile_report.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportSummaryScrean extends StatefulWidget {
  const ReportSummaryScrean({Key? key}) : super(key: key);

  @override
  State<ReportSummaryScrean> createState() => _ReportSummaryScreanState();
}

class _ReportSummaryScreanState extends State<ReportSummaryScrean> {
// double.parse((12.3412).toStringAsFixed(2));
  String selectedYear = "0";

  String selectedMonth = "0";

  String selectedDay = "0";

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocConsumer<ReportSummaryCubit, ReportSummaryState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ReportSummaryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ReportSummarySucces) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                t!.reportSummary,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.filter_alt_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => FiltterDialog(
                              onpressed: () {
                                BlocProvider.of<ReportSummaryCubit>(context)
                                    .getReportSummary(
                                        m: selectedMonth, y: selectedYear)
                                    .then((value) {
                                  Navigator.pop(context, 'ok');
                                  selectedYear = selectedMonth = "0";
                                });
                              },
                              onselectedYear: (value) {
                                selectedYear = value;
                              },
                              onselectedMonth: (value) {
                                selectedMonth = value;
                              },
                              onselectedDay: (value) {
                                selectedDay = value;
                              },
                              showDay: false,
                            ));
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                  child: Text(
                    "${state.reportModel.data.month} / ${state.reportModel.data.year}",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                CardTileReport(
                  hour: state.reportModel.data.actTime,
                  title: t.realtime,
                ),
                CardTileReport(
                  hour: state.reportModel.data.overTime,
                  title: t.extratime,
                ),
                CardTileReport(
                  hour: state.reportModel.data.goEarly,
                  title: t.earlydeparture,
                ),
                CardTileReport(
                  hour: state.reportModel.data.avlTime,
                  title: t.delayperiod,
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
