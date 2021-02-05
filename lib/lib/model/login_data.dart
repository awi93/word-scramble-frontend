import 'package:equatable/equatable.dart';

class LoginData extends Equatable {
  String _username;
  String _password;

  String get username => _username;

  set username(String value) => _username = value;

  String get password => _password;

  set password(String value) => _password = value;

  @override
  List<Object> get props => [username];
}
