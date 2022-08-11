import 'package:dio/dio.dart';
import 'package:fingerprint/features/check_token/bloc/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/local/hiva_helper.dart';
import 'features/auth/view/login.dart';
import 'features/check_token/bloc/check_token_cubit.dart';
import 'features/finger/view/finger.dart';
import 'features/management/time_sheet_cubit/time_sheet_cubit.dart';
import 'features/management/view/management.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/report_summary/report_summary_cubit/report_summary_cubit.dart';
import 'features/report_summary/view/report_summary_screan.dart';
import 'features/user_data/user_data_cubit/user_data_cubit.dart';
import 'features/user_data/user_data_cubit/user_data_state.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  final List<Widget> widgetOptions = [
    const FingerPrint(),
    const Management(),
    const ReportSummaryScrean(),
    // Account(),
  ];

  void _selectpage(int value) {
    setState(() => index = value);
  }

  @override
  void initState() {
    BlocProvider.of<CheckTokenCubit>(context).checkToken(context);

    //Dio

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      body: BlocConsumer<CheckTokenCubit, CheckTokenStatus>(
        listener: (context, state) {
          if (state is CheckTokenLoaded) {
            BlocProvider.of<UserDataCubit>(context).getUserData().then((e) {
              BlocProvider.of<TimeSheetCubit>(context)
                  .getTimeSheetData()
                  .then((e) {
                BlocProvider.of<ReportSummaryCubit>(context).getReportSummary();
              });
            });
          }
        },
        builder: (context, state) {
          if (state is CheckTokenLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CheckTokenLoaded) {
            return SafeArea(child: widgetOptions[index]);
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.fingerprint),
            label: t!.finger,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.pencil_outline),
            label: t.reports,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.article_outlined),
            label: t.reportSummary,
          ),
        ],
      ),
    );
  }
}
