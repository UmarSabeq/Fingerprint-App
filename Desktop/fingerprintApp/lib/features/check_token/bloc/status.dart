import 'package:equatable/equatable.dart';

class CheckTokenStatus extends Equatable {
  const CheckTokenStatus();

  @override
  List<Object> get props => [];
}

class CheckTokenInitial extends CheckTokenStatus {}

class CheckTokenLoading extends CheckTokenStatus {}

class CheckTokenLoaded extends CheckTokenStatus {}

class CheckTokenError extends CheckTokenStatus {
  final String massage;

  const CheckTokenError(this.massage);

  @override
  List<Object> get props => [massage];
}
