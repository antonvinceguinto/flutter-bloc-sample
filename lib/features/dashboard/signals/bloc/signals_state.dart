part of 'signals_bloc.dart';

abstract class SignalsState extends Equatable {
  const SignalsState();

  @override
  List<Object> get props => [];
}

class SignalsLoading extends SignalsState {}

class SignalsLoaded extends SignalsState {
  const SignalsLoaded({required this.signals});

  final List<Signal> signals;

  @override
  List<Object> get props => [signals];
}
