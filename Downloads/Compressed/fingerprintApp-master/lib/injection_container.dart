import 'package:dio/dio.dart';
import 'package:fingerprint/features/auth/repositories/auth_repositories.dart';
import 'package:fingerprint/features/check_token/bloc/check_token_cubit.dart';
import 'package:fingerprint/features/check_token/repoisitories/ckeck_token_repositiry.dart';
import 'package:fingerprint/features/management/repositories/timesheet_repositories.dart';
import 'package:get_it/get_it.dart';

import 'core/constant/apis.dart';
import 'core/localization/language_cubit.dart';
import 'data/local/hiva_helper.dart';
import 'data/remote/dio_helper.dart';
import 'features/auth/auth_cubit/auth_cubit.dart';
import 'features/finger/finger_cubit/finger_cubit.dart';
import 'features/finger/repositories/finger_repositories.dart';
import 'features/management/time_sheet_cubit/time_sheet_cubit.dart';
import 'features/report_summary/report_summary_cubit/report_summary_cubit.dart';
import 'features/report_summary/reposiories/report_summary_reosiorie.dart';
import 'features/user_data/repositories/user_data_repositories.dart';
import 'features/user_data/user_data_cubit/user_data_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
// Bloc
  getIt.registerFactory(() => AuthCubit(sigInRepository: getIt()));
  getIt.registerFactory(() => TimeSheetCubit(timeSheetRepository: getIt()));
  getIt.registerFactory(() => FingerCubit(fingerRepositorie: getIt()));
  getIt.registerFactory(() => LanguageCubit(getIt()));
  getIt.registerFactory(
      () => ReportSummaryCubit(reportSummaryReosiorie: getIt()));
  getIt.registerFactory(() => UserDataCubit(userDataRepositories: getIt()));
  getIt.registerFactory(() => CheckTokenCubit(checkTokenRepositiry: getIt()));

  // Repository
  getIt.registerLazySingleton(
      () => SigInRepository(dio: getIt(), hiveHelper: getIt()));
  getIt.registerLazySingleton(() => TimeSheetRepository(dio: getIt()));
  getIt.registerLazySingleton(() => FingerRepositorie(dioHelper: getIt()));
  getIt.registerLazySingleton(() => ReportSummaryReosiorie(dio: getIt()));
  getIt.registerLazySingleton(
      () => UserDataRepositories(dio: getIt(), hiveHelper: getIt()));
  getIt.registerLazySingleton(() => CheckTokenRepositiry(dio: getIt()));

  // Data sources
  getIt.registerLazySingleton(() => HiveHelper());

  // External

  getIt.registerLazySingleton(
      () => DioHelper(dio: getIt(), hiveHelper: getIt()));
  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: FingerPrint.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    ),
  );
}
