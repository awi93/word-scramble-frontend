import 'package:equatable/equatable.dart';
import 'package:word_scramble_frontend/lib/model/question.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class Submission extends Equatable {

  String _id;
  int _userId;
  String _questionId;
  String _answer;
  int _point;
  bool _isTrue;
  DateTime _createdAt;
  DateTime _updatedAt;
  String _createdBy;
  String _updatedBy;
  Question _question;

  String get id => _id;

  int get userId => _userId;

  String get questionId => _questionId;

  String get answer => _answer;

  int get point => _point;

  bool get isTrue => _isTrue;

  DateTime get createdAt => _createdAt;

  DateTime get updatedAt => _updatedAt;

  String get createdBy => _createdBy;

  String get updatedBy => _updatedBy;

  Question get question => _question;

  set question(Question value) {
    _question = value;
  }

  set updatedBy(String value) {
    _updatedBy = value;
  }

  set createdBy(String value) {
    _createdBy = value;
  }

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  set isTrue(bool value) {
    _isTrue = value;
  }

  set point(int value) {
    _point = value;
  }

  set answer(String value) {
    _answer = value;
  }

  set questionId(String value) {
    _questionId = value;
  }

  set userId(int value) {
    _userId = value;
  }

  set id(String value) {
    _id = value;
  }

  @override
  // TODO: implement props
  List<Object> get props => [id];

  static Submission fromJson (Map<String, dynamic> json) {
    if (json == null) return null;

    Submission data = new Submission();
    data.id = json["id"];
    data.userId = json["user_id"];
    data.questionId = json["question_id"];
    data.answer = json["answer"];
    data.point = json["point"];
    data.isTrue = json["is_true"];
    data.createdAt = MixUtil.millisToDateTime(json["created_at"]);
    data.updatedAt = MixUtil.millisToDateTime(json["updated_at"]);
    data.createdBy = json["created_by"];
    data.updatedBy = json["updated_by"];
    data.question = Question.fromJson(json["question"]);

    return data;
  }

  Map<String, dynamic> toJson () => {
    "id" : this.id,
    "user_id" : this.userId,
    "question_id" : this.questionId,
    "answer" : this.answer,
    "point" : this.point,
    "is_true" : this.isTrue,
    "created_at" : MixUtil.datetimeToMillis(this.createdAt),
    "updated_at" : MixUtil.datetimeToMillis(this.updatedAt),
    "created_by" : this.createdBy,
    "updated_by" : this.updatedBy,
    "question" : this.question != null ? this.question.toJson() : null
  };

}