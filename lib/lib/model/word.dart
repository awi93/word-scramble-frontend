import 'package:equatable/equatable.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class Word extends Equatable {

  String _id;
  String _word;
  DateTime _createdAt;
  DateTime _updatedAt;
  String _createdBy;
  String _updatedBy;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get word => _word;

  set word(String value) {
    _word = value;
  }

  String get updatedBy => _updatedBy;

  set updatedBy(String value) {
    _updatedBy = value;
  }

  String get createdBy => _createdBy;

  set createdBy(String value) {
    _createdBy = value;
  }

  DateTime get updatedAt => _updatedAt;

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  @override
  // TODO: implement props
  List<Object> get props => [id,word];

  static Word fromJson (Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    Word data = new Word();
    data.id = json["id"];
    data.word = json["word"];
    data.createdAt = MixUtil.millisToDateTime(json["created_at"]);
    data.updatedAt = MixUtil.millisToDateTime(json["updated_at"]);
    data.createdBy = json["created_by"];
    data.updatedBy = json["updated_by"];

    return data;
  }

  Map<String, dynamic> toJson () => {
    "id" : this.id,
    "word" : this.word,
    "created_at" : MixUtil.datetimeToMillis(this.createdAt),
    "updated_at" : MixUtil.datetimeToMillis(this.updatedAt),
    "created_by" : this.createdBy,
    "updated_by" : this.updatedBy
  };

}