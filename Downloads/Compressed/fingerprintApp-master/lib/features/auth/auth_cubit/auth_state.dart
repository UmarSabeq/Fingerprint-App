import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String massage;

  const AuthError(this.massage);

  @override
  List<Object> get props => [massage];
}

// class HideFeaturesLoading extends AuthState {}

// class HideFeaturesLoaded extends AuthState {}
