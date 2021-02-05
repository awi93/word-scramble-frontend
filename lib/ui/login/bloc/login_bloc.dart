import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:word_scramble_frontend/lib/model/access_token.dart';
import 'package:word_scramble_frontend/lib/model/login_data.dart';
import 'package:word_scramble_frontend/lib/model/user.dart';
import 'package:word_scramble_frontend/lib/model/user_existency.dart';
import 'package:word_scramble_frontend/lib/repo/auth_repo.dart';
import 'package:word_scramble_frontend/lib/repo/user_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CheckUserExistencyEvent) {
      try {
        yield new LoadingState();
        UserExistency data =
            await UserRepo.instance().fetchUserExistency(event.data.username);
        if (data.existency != true) {
          this.add(RegisterUserEvent(event.data));
        } else {
          LoginData data = new LoginData();
          data.username = event.data.username;
          data.password = "player123";
          this.add(LoginUserEvent(data));
        }
      } catch (e) {
        yield new FailToLoginState();
      }
    } else if (event is RegisterUserEvent) {
      try {
        yield new LoadingState();
        User data = await UserRepo.instance().saveUser(event.data);
        LoginData d = new LoginData();
        d.username = data.username;
        d.password = "player123";
        this.add(LoginUserEvent(d));
      } catch (e) {
        yield new FailToLoginState();
      }
    } else if (event is LoginUserEvent) {
      try {
        yield new LoadingState();
        AccessToken toke =
            await AuthRepo.instance().fetchUserAccessToken(event.data);
        AuthRepo.instance().saveAccessToken(toke);
        User data = await UserRepo.instance().fetchMe();
        yield new UserLoggedInState(data);
      } catch (e) {
        yield new FailToLoginState();
      }
    }
  }
}
