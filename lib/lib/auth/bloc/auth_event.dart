part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class ForTokenEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final User user;
  LoginEvent(this.user);
}

class LogoutEvent extends AuthEvent {}
