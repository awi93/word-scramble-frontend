import 'package:equatable/equatable.dart';
import 'package:word_scramble_frontend/lib/model/user.dart';

class VwUserPoint extends Equatable {

  int _userId;
  int _point;
  User _user;

  int get userId => _userId;

  set userId (int value) {
    _userId = value;
  }

  int get point => _point;

  set point(int value) {
    _point = value;
  }

  User get user => _user;

  set user (User value) {
    _user = value;
  }

  static VwUserPoint fromJson (Map<String, dynamic> json) {
    if (json == null)
      return null;

    VwUserPoint data = new VwUserPoint();
    data.userId = json["user_id"];
    data.point = json["point"];
    data.user = User.fromJson(json["user"]);

    return data;
  }

  Map<String, dynamic> toJson() => {
    "user_id" : this.userId,
    "point" : this.point,
    "user" : this.user.toJson()
  };

  @override
  // TODO: implement props
  List<Object> get props => [userId];

}