part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitState extends AuthState {}

class AnonymousState extends AuthState {}

class AuthenticatedState extends AuthState {
  User user;
  AuthenticatedState(this.user);
}

class FailToInitiateAuthState extends AuthState {
  final ErrorType errorType;
  final Map<String, dynamic> errors;

  FailToInitiateAuthState(this.errorType, this.errors);
}
