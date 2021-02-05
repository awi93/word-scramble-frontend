part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class UserLoggedInState extends LoginState {
  User data;
  UserLoggedInState(this.data);
}

class FailToLoginState extends LoginState {}
