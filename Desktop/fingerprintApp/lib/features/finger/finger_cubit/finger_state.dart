import 'package:equatable/equatable.dart';

class FingerState extends Equatable {
  const FingerState();

  @override
  List<Object> get props => [];
}

class FingerInitial extends FingerState {}

//get location state
class GetLocaionLoading extends FingerState {}

class GetLocaionLoaded extends FingerState {}

class GetLocaionError extends FingerState {
  final String massage;

  const GetLocaionError(this.massage);

  @override
  List<Object> get props => [massage];
}

//Sing Finger
class SingFingerLoading extends FingerState {}

class SingFingerLoaded extends FingerState {
  final Map<String, dynamic> data;
  const SingFingerLoaded({required this.data});
}

class SingOutFingerLoaded extends FingerState {
  final Map<String, dynamic> data;
  const SingOutFingerLoaded({required this.data});
}

class SingFingerError extends FingerState {
  final String massage;

  const SingFingerError(this.massage);

  @override
  List<Object> get props => [massage];
}
