import 'dart:convert';

import 'package:word_scramble_frontend/lib/model/user.dart';
import 'package:word_scramble_frontend/lib/model/user_existency.dart';
import 'package:word_scramble_frontend/lib/model/vw_user_point.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class UserRepo {
  static UserRepo _instance;
  static UserRepo instance() {
    if (_instance == null) _instance = new UserRepo();
    return _instance;
  }

  Future<User> fetchMe() async {
    try {
      final response = await MixUtil.get("/me");

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        return User.fromJson(json);
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }

  Future<VwUserPoint> fetchPoint(int userId) async {
    try {
      final response = await MixUtil.get("/users/$userId/point");

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        return VwUserPoint.fromJson(json);
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }

  Future<UserExistency> fetchUserExistency(String username) async {
    try {
      final response =
          await MixUtil.get("/user-existencies?username=" + username);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        return UserExistency.fromJson(json);
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }

  Future<User> saveUser(User data) async {
    try {
      Map<String, dynamic> body = {
        "username": data.username,
        "user_type": data.userType,
        "name": data.name
      };
      if (body == null) throw Exception("Invalid Body");

      final response = await MixUtil.post("/users", body);

      if (response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        return User.fromJson(json["data"]);
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }
}
