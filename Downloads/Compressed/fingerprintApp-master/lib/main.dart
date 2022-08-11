import 'package:fingerprint/features/check_token/bloc/check_token_cubit.dart';
import 'package:fingerprint/features/management/time_sheet_cubit/time_sheet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/localization/language_cubit.dart';
import 'core/style/them.dart';
import 'data/local/hiva_helper.dart';
import 'features/auth/auth_cubit/auth_cubit.dart';
import 'features/auth/view/login.dart';
import 'features/finger/finger_cubit/finger_cubit.dart';
import 'features/report_summary/report_summary_cubit/report_summary_cubit.dart';
import 'features/user_data/user_data_cubit/user_data_cubit.dart';
import 'injection_container.dart';
import 'myobserver.dart';
import 'nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  await init();
  String? token = HiveHelper().getData("token");
  print(token);
  Widget startWidget;
  if (token != null) {
    startWidget = const NavBar();
  } else {
    startWidget = const Signin();
  }
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  BlocOverrides.runZoned(
    () => runApp(MyApp(startWidget: startWidget)),
    blocObserver: MyObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
          BlocProvider<CheckTokenCubit>(
              create: (context) => getIt<CheckTokenCubit>()),
          BlocProvider<TimeSheetCubit>(
              create: (context) => getIt<TimeSheetCubit>()),
          BlocProvider<ReportSummaryCubit>(
              create: (context) => getIt<ReportSummaryCubit>()),
          BlocProvider<FingerCubit>(create: (context) => getIt<FingerCubit>()),
          BlocProvider<UserDataCubit>(
              create: (context) => getIt<UserDataCubit>()),
          BlocProvider<LanguageCubit>(
              create: (context) => getIt<LanguageCubit>()),
        ],
        child: BlocBuilder<LanguageCubit, Locale>(builder: (_, locale) {
          return MaterialApp(
            title: 'TS Finger',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            home: startWidget,
          );
        }));
  }
}
