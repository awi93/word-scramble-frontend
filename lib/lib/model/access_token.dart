import 'package:equatable/equatable.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class AccessToken extends Equatable {
  final String _tokenType;
  final DateTime _expireTime;
  final String _accessToken;
  final String _refreshToken;

  AccessToken(
      this._tokenType, this._expireTime, this._accessToken, this._refreshToken);

  String get refreshToken => _refreshToken;

  String get accessToken => _accessToken;

  DateTime get expireTime => _expireTime;

  String get tokenType => _tokenType;

  @override
  static AccessToken fromJson(Map<String, dynamic> json) {
    return new AccessToken(
        json['token_type'],
        MixUtil.millisToDateTime(json["expire_time"]),
        json['access_token'],
        json.containsKey("refresh_token") ? json['refresh_token'] : null);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'token_type': this._tokenType,
        'expire_time': MixUtil.datetimeToMillis(this.expireTime),
        'access_token': this._accessToken,
        'refresh_token': this._refreshToken
      };

  @override
  List<Object> get props => [tokenType, accessToken];
}
