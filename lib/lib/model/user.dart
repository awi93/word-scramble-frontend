import 'package:equatable/equatable.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class User extends Equatable {
  int _id;
  String _username;
  String _name;
  String _userType;
  DateTime _createdAt;
  DateTime _updatedAt;
  int get id => _id;

  set id(int value) => _id = value;

  String get username => _username;

  set username(String value) => _username = value;

  String get name => _name;

  set name(String value) => _name = value;

  String get userType => _userType;

  set userType(String value) => _userType = value;

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) => _createdAt = value;

  DateTime get updatedAt => _updatedAt;

  set updatedAt(DateTime value) => _updatedAt = value;

  @override
  List<Object> get props => [username];

  static User fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;

    User data = new User();
    data.id = json["id"];
    data.username = json["username"];
    data.name = json["name"];
    data.userType = json["user_type"];
    data.createdAt = MixUtil.millisToDateTime(json["created_at"]);
    data.updatedAt = MixUtil.millisToDateTime(json["updated_at"]);
    return data;
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "username": this.username,
        "name": this.name,
        "user_type": this.userType,
        "created_at": MixUtil.datetimeToMillis(this.createdAt),
        "updated_at": MixUtil.datetimeToMillis(this.updatedAt)
      };
}
