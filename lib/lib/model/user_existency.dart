import 'package:equatable/equatable.dart';
import 'package:word_scramble_frontend/lib/model/user.dart';

class UserExistency extends Equatable {
  bool _existency;
  User _data;

  bool get existency => _existency;

  set existency(bool value) {
    _existency = value;
  }

  User get data => _data;

  set data(User value) {
    _data = value;
  }

  static UserExistency fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    UserExistency data = new UserExistency();
    data.existency = json["existency"];
    data.data = User.fromJson(json["data"]);

    return data;
  }

  Map<String, dynamic> toJson() => {
        "existency": this.existency,
        "data": (this.data != null) ? this.data.toJson() : null
      };

  @override
  List<Object> get props => [existency, data];
}
