import 'dart:convert';

import 'package:word_scramble_frontend/lib/model/access_token.dart';
import 'package:word_scramble_frontend/lib/model/login_data.dart';
import 'package:word_scramble_frontend/lib/model/user.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class AuthRepo {
  static AuthRepo _instance;

  static AuthRepo instance() {
    if (_instance == null) _instance = new AuthRepo();
    return _instance;
  }

  AccessToken getAccessToken() {
    String token = MixUtil.preferences.getString("access_token");

    if (token == null) return null;

    AccessToken accessToken = AccessToken.fromJson(jsonDecode(token));

    return accessToken;
  }

  void saveAccessToken(AccessToken token) {
    MixUtil.preferences.setString("access_token", jsonEncode(token.toJson()));
  }

  void deleteAccessToken() {
    MixUtil.preferences.remove("access_token");
  }

  User getUser() {
    String data = MixUtil.preferences.getString("user");
    if (data == null) return null;
    User user = User.fromJson(jsonDecode(data));
    return user;
  }

  void saveUser(User user) {
    MixUtil.preferences.setString("user", jsonEncode(user.toJson()));
  }

  void deleteUser() {
    MixUtil.preferences.remove("user");
  }

  Future<AccessToken> refreshAccessToken(AccessToken accessToken) async {
    try {
      final response = await MixUtil.post("/oauth.token", {
        "grant_type": "refresh_token",
        "client_id": MixUtil.clientId,
        "client_secret": MixUtil.clientPassword,
        "refresh_token": accessToken.refreshToken
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        json["token_type"] = "USER";

        DateTime expTime = DateTime.now();
        expTime = expTime.add(Duration(seconds: json["expires_in"] - 86400));
        json["expire_time"] = MixUtil.datetimeToMillis(expTime);

        AccessToken accessToken = AccessToken.fromJson(json);

        AuthRepo.instance().saveAccessToken(accessToken);

        return accessToken;
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }

  Future<AccessToken> fetchUserAccessToken(LoginData data) async {
    try {
      /**
       * Building body according to LoginType variable
       */
      Map<String, dynamic> body = {};
      body = {
        "grant_type": "password",
        "username": data.username,
        "password": data.password,
        "scope" : ""
      };
      body["client_id"] = MixUtil.clientId;
      body["client_secret"] = MixUtil.clientPassword;

      final response = await MixUtil.post("/oauth/token", body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        json["token_type"] = "USER";

        DateTime expTime = DateTime.now();
        expTime = expTime.add(Duration(seconds: json["expires_in"] - 86400));
        json["expire_time"] = MixUtil.datetimeToMillis(expTime);

        AccessToken accessToken = AccessToken.fromJson(json);

        AuthRepo.instance().saveAccessToken(accessToken);

        return accessToken;
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }

  Future<bool> isAccessTokenValid() async {
    try {
      final AccessToken accessToken = AuthRepo.instance().getAccessToken();
      String url = "/user-auth";

      final response = await MixUtil.get(url);

      if (response.statusCode == 200) return true;

      return false;
    } catch (e, s) {
      return false;
    }
  }
}
