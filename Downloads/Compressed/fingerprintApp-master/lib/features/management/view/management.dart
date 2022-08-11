import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../time_sheet_cubit/time_sheet_cubit.dart';
import '../time_sheet_cubit/time_sheet_state.dart';
import '../widget/filter_dialog.dart';

class Management extends StatefulWidget {
  const Management({
    Key? key,
  }) : super(key: key);

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  String selectedYear = "0";

  String selectedMonth = "0";

  String selectedDay = "0";

  int currentIndex = 0;
  double dyilytime = 0;
  double overtime = 0;
  double earlytime = 0;

  int sumTime(int num) {
    return num;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return BlocConsumer<TimeSheetCubit, TimeSheetState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is TimeSheetLogin) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is TimeSheetSucces) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                t!.reports,
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
                                BlocProvider.of<TimeSheetCubit>(context)
                                    .getTimeSheetData(
                                        d: selectedDay,
                                        m: selectedMonth,
                                        y: selectedYear)
                                    .then((value) {
                                  Navigator.pop(context, 'ok');
                                  selectedYear =
                                      selectedMonth = selectedDay = "0";
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
                            ));
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          border: TableBorder.all(
                              color: Colors.black.withOpacity(0.2)),
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            return Theme.of(context)
                                .colorScheme
                                .primary; // Use the default value.
                          }),
                          headingTextStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                          columns: [
                            DataColumn(
                              label: Text(
                                t.date,
                              ),
                            ),
                            DataColumn(
                              label: Text(t.workingtime),
                            ),
                            DataColumn(
                              label: Text(t.typeworke),
                            ),
                            DataColumn(
                              label: Text(t.timeattendance),
                            ),
                            DataColumn(
                              label: Text(t.delayperiod),
                            ),
                            DataColumn(
                              label: Text(t.checkouttime),
                            ),
                            DataColumn(
                              label: Text(t.realtime),
                            ),
                            DataColumn(
                              label: Text(t.extratime),
                            ),
                            DataColumn(
                              label: Text(t.earlydeparture),
                            ),
                          ],
                          rows: state.reportModel.data.map((e) {
                            return DataRow(cells: [
                              DataCell(Text(DateFormat.yMMMMd()
                                  .format(e.day!)
                                  .toString())),
                              DataCell(Column(
                                children: e.shifts!
                                    .map((e) => Expanded(
                                          child: Text(e.timeStart! +
                                              " ${t.to} " +
                                              e.timeEnd!),
                                        ))
                                    .toList(),
                              )),
                              DataCell(Column(
                                children: e.shifts!
                                    .map((e) => Expanded(child: Text(e.title!)))
                                    .toList(),
                              )),
                              DataCell(Text(e.timeStart ?? "----")),
                              DataCell(Text(e.delayTime ?? "----")),
                              DataCell(Text(e.timeEnd ?? "----")),
                              DataCell(Text(e.actualTime ?? "----")),
                              DataCell(Text(e.overTime ?? "----")),
                              DataCell(Text(e.goEarly ?? "----")),
                            ]);
                          }).toList(),
                        ),
                      )),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
