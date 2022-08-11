import 'package:equatable/equatable.dart';

import '../../../model/userdata_model.dart';

class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserDataState {}

class GetUserDataLoading extends UserDataInitial {}

class GetUserDataLoaded extends UserDataInitial {
  final UserDataModel userDataModel;

  GetUserDataLoaded(this.userDataModel);

  @override
  List<Object> get props => [userDataModel];
}

class GetUserDataError extends UserDataInitial {
  final String massage;

  GetUserDataError(this.massage);

  @override
  List<Object> get props => [massage];
}
