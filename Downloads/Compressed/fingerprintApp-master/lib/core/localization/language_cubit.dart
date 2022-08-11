import 'package:fingerprint/data/local/hiva_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  final HiveHelper hiveHelper;
  LanguageCubit(this.hiveHelper) : super(const Locale("en")) {
    emitLocale();
  }

  bool langcode = false;
  emitLocale() async {
    // langCode = await hiveHelper.getData("lang") ?? "en";
    emit(Locale(await hiveHelper.getData("lang") ?? "en"));
  }

  selectEngLanguage() async {
    if (langcode) {
      langcode = !langcode;
      await hiveHelper.putData("lang", "en");
      // langCode = 'en';
      emit(const Locale('en'));
    } else {
      langcode = !langcode;
      await hiveHelper.putData("lang", "ar");
      // langCode = 'ar';
      emit(const Locale('ar'));
    }
    // await hiveHelper.putData("lang", "en");
    // // langCode = 'en';
    // emit(const Locale('en'));
  }

  void selectArabicLanguage() async {
    await hiveHelper.putData("lang", "ar");
    // langCode = 'ar';
    emit(const Locale('ar'));
  }
}
