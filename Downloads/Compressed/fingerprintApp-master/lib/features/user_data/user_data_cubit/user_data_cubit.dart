import 'package:bloc/bloc.dart';
import 'package:fingerprint/features/user_data/user_data_cubit/user_data_state.dart';

import '../../../data/local/hiva_helper.dart';
import '../../../model/userdata_model.dart';
import '../repositories/user_data_repositories.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit({required this.userDataRepositories})
      : super(UserDataInitial());
  final UserDataRepositories userDataRepositories;
  int? ftra = HiveHelper().getData("shift");
  Future getUserData() async {
    emit(GetUserDataLoading());
    try {
      UserDataModel userDataModel = await userDataRepositories.getUserData();

      ftra = userDataModel.data.ftra;
      await HiveHelper().putData("shift", userDataModel.data.ftra);
      emit(GetUserDataLoaded(userDataModel));
    } catch (e) {
      emit(GetUserDataError(e.toString()));
    }
  }
}
