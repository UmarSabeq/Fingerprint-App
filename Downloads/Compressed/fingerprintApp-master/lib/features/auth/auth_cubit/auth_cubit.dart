import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../repositories/auth_repositories.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.sigInRepository}) : super(AuthInitial());
  final SigInRepository sigInRepository;

  singIn({required String phone, required String password}) async {
    emit(AuthLoading());
    try {
      await sigInRepository.signIn(phone: phone, password: password);
      emit(AuthSuccess());
    } catch (e) {
      log(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  singUp({
    required String phone,
    required String password,
    required String name,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoading());
    try {
      await sigInRepository.signUp(
          phone: phone,
          password: password,
          name: name,
          passwordConfirmation: passwordConfirmation);
      emit(AuthSuccess());
    } catch (e) {
      log(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  forgetPassWord({
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoading());
    try {
      await sigInRepository.forgetPassword(
          phone: phone,
          password: password,
          passwordConfirmation: passwordConfirmation);
      emit(AuthSuccess());
    } catch (e) {
      log(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  // hideFeatures() async {
  //   emit(HideFeaturesLoading());
  //   try {
  //     await sigInRepository.hideFeatures();
  //     emit(HideFeaturesLoaded());
  //   } catch (e) {
  //     log(e.toString());
  //     emit(AuthError(e.toString()));
  //   }
  // }
}
