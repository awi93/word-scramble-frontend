import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:word_scramble_frontend/lib/error/error_response_exception.dart';
import 'package:word_scramble_frontend/lib/error/error_type.dart';
import 'package:word_scramble_frontend/lib/model/access_token.dart';
import 'package:word_scramble_frontend/lib/model/user.dart';
import 'package:word_scramble_frontend/lib/repo/auth_repo.dart';
import 'package:word_scramble_frontend/lib/repo/user_repo.dart';
import 'package:word_scramble_frontend/ui/login/bloc/login_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitState());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is ForTokenEvent) {
      try {
        yield new AnonymousState();

        AccessToken token = await _fetchOrRefreshAccessToken();

        if (token == null) {
          yield new AnonymousState();
        } else {
          User data = await UserRepo.instance().fetchMe();
          this.add(LoginEvent(data));
        }
      } on ErrorResponseException catch (e) {
        yield new FailToInitiateAuthState(
            ErrorTypeTranslator.translate(e.statusCode), e.errors);
      } catch (e) {
        yield new FailToInitiateAuthState(ErrorType.CONNECTION_ERROR, null);
      }
    } else if (event is LoginEvent) {
      AuthRepo.instance().saveUser(event.user);
      yield new AuthenticatedState(event.user);
    } else if (event is LogoutEvent) {
      AuthRepo.instance().deleteAccessToken();
      AuthRepo.instance().deleteUser();
      yield new AnonymousState();
    }
  }

  Future<AccessToken> _fetchOrRefreshAccessToken() async {
    AccessToken accessToken = AuthRepo.instance().getAccessToken();
    try {
      if (accessToken == null) {
        return null;
      } else {
        DateTime now = DateTime.now();
        if (now.isAfter(accessToken.expireTime)) {
          if (accessToken.tokenType == "USER" &&
              accessToken.refreshToken != null) {
            final AccessToken newToken =
                await AuthRepo.instance().refreshAccessToken(accessToken);
            return newToken;
          }

          return null;
        }

        return accessToken;
      }
    } catch (e) {
      throw e;
    }
  }
}
