part of 'init_bloc.dart';

abstract class InitState extends Equatable {
  const InitState();

  @override
  List<Object> get props => [];
}

class InitInitial extends InitState {}

class InitializedState extends InitState {}

class FailToInitState extends InitState {
  final ErrorType errorType;
  final Map<String, dynamic> errors;

  FailToInitState(this.errorType, this.errors);
}
