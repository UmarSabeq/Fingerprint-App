import 'package:bloc/bloc.dart';
import 'package:fingerprint/features/check_token/bloc/status.dart';
import 'package:flutter/material.dart';

import '../../../data/local/hiva_helper.dart';
import '../../auth/view/login.dart';
import '../repoisitories/ckeck_token_repositiry.dart';

class CheckTokenCubit extends Cubit<CheckTokenStatus> {
  CheckTokenCubit({required this.checkTokenRepositiry})
      : super(CheckTokenInitial());

  CheckTokenRepositiry checkTokenRepositiry;
  checkToken(BuildContext context) async {
    emit(CheckTokenLoading());
    try {
      await checkTokenRepositiry.checkToken();
      emit(CheckTokenLoaded());
    } catch (e) {
      print("skksksksk");

      // HiveHelper().removeData("token");
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute<void>(
      //       builder: (BuildContext context) => const Signin()),
      //   (route) => false,
      // );

      emit(CheckTokenError(e.toString()));
    }
  }
}
