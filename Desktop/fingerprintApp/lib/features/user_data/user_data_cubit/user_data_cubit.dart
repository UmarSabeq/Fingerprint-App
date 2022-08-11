import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fingerprint/features/user_data/user_data_cubit/user_data_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/local/hiva_helper.dart';
import '../../../model/userdata_model.dart';
import '../../auth/view/login.dart';
import '../repositories/user_data_repositories.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit({required this.userDataRepositories})
      : super(UserDataInitial());
  final UserDataRepositories userDataRepositories;
  Future getUserData() async {
    emit(GetUserDataLoading());
    try {
      UserDataModel userDataModel = await userDataRepositories.getUserData();
      emit(GetUserDataLoaded(userDataModel));
    } catch (e) {
      emit(GetUserDataError(e.toString()));
    }
  }
}
