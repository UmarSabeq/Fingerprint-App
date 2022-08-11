import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FiltterDialog extends StatefulWidget {
  const FiltterDialog(
      {Key? key,
      required this.onselectedYear,
      required this.onselectedMonth,
      required this.onselectedDay,
      required this.onpressed,
      this.showDay = true})
      : super(key: key);
  final ValueChanged<String> onselectedYear;
  final ValueChanged<String> onselectedMonth;
  final ValueChanged<String> onselectedDay;
  final Function()? onpressed;
  final bool showDay;

  @override
  State<FiltterDialog> createState() => _FiltterDialogState();
}

class _FiltterDialogState extends State<FiltterDialog> {
  int currentIndex = 0;

  String selectedYear = "0";

  String selectedMonth = "0";

  String selectedDay = "0";

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(t!.cancel),
          ),
          TextButton(
            onPressed: widget.onpressed,
            child: Text(t.search),
          ),
        ],
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TabBar(
              onTap: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              tabs: [
                Tab(
                  child: Text(t.year),
                ),
                Tab(
                  child: Text(t.month),
                ),
                widget.showDay
                    ? Tab(
                        child: Text(t.day),
                      )
                    : const SizedBox.shrink(),
              ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.8,
            child: TabBarView(
              children: <Widget>[
                SfDateRangePicker(
                  view: DateRangePickerView.decade,
                  allowViewNavigation: false,
                  onSelectionChanged: (value) {
                    final sected = DateTime.parse(value.value.toString());
                    selectedYear = sected.year.toString();
                    widget.onselectedYear(selectedYear);
                    log(selectedYear);
                  },
                ),
                SfDateRangePicker(
                  view: DateRangePickerView.year,
                  allowViewNavigation: false,
                  onSelectionChanged: (value) async {
                    final sected = DateTime.parse(value.value.toString());
                    selectedMonth = sected.month.toString();
                    widget.onselectedMonth(selectedMonth);
                    log(selectedMonth);
                  },
                ),
                SfDateRangePicker(
                  view: DateRangePickerView.month,
                  allowViewNavigation: false,
                  onSelectionChanged: (value) {
                    final sected = DateTime.parse(value.value.toString());
                    selectedDay = sected.day.toString();
                    widget.onselectedDay(selectedDay);
                    log(selectedDay);
                  },
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
