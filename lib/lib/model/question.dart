import 'package:equatable/equatable.dart';
import 'package:word_scramble_frontend/lib/model/word.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class Question extends Equatable {

  String _id;
  String _wordId;
  String _scrambled;
  DateTime _createdAt;
  DateTime _updatedAt;
  String _createdBy;
  String _updatedBy;
  Word _word;

  set id(String value) {
    _id = value;
  }

  set wordId(String value) {
    _wordId = value;
  }

  set scrambled(String value) {
    _scrambled = value;
  }

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  set createdBy(String value) {
    _createdBy = value;
  }

  set updatedBy(String value) {
    _updatedBy = value;
  }

  set word(Word value) {
    _word = value;
  }

  String get id => _id;

  String get wordId => _wordId;

  String get scrambled => _scrambled;

  DateTime get createdAt => _createdAt;

  DateTime get updatedAt => _updatedAt;

  String get createdBy => _createdBy;

  String get updatedBy => _updatedBy;

  Word get word => _word;

  @override
  // TODO: implement props
  List<Object> get props => [id,wordId];

  static Question fromJson (Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    Question data = new Question();
    data.id = json["id"];
    data.wordId = json["word_id"];
    data.scrambled = json["scrambled"];
    data.word = Word.fromJson(json["word"]);
    data.createdAt = MixUtil.millisToDateTime(json["created_at"]);
    data.updatedAt = MixUtil.millisToDateTime(json["updated_at"]);
    data.createdBy = json["created_by"];
    data.updatedBy = json["updated_by"];

    return data;
  }

  Map<String, dynamic> toJson () => {
    "id" : this.id,
    "word_id" : this.wordId,
    "scrambled" : this.scrambled,
    "created_at" : MixUtil.datetimeToMillis(this.createdAt),
    "updated_at" : MixUtil.datetimeToMillis(this.updatedAt),
    "created_by" : this.createdBy,
    "updated_by" : this.updatedBy,
    "word" : (this.word != null) ? this.word.toJson() : null
  };

}