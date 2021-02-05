part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class CheckUserExistencyEvent extends LoginEvent {
  User data;

  CheckUserExistencyEvent(this.data);
}

class LoginUserEvent extends LoginEvent {
  LoginData data;
  LoginUserEvent(this.data);
}

class RegisterUserEvent extends LoginEvent {
  User data;
  RegisterUserEvent(this.data);
}
