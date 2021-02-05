import 'dart:convert';
import 'dart:html';

import 'package:word_scramble_frontend/lib/model/paging.dart';
import 'package:word_scramble_frontend/lib/model/question.dart';
import 'package:word_scramble_frontend/lib/model/submission.dart';
import 'package:word_scramble_frontend/lib/model/vw_user_point.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';
import 'package:word_scramble_frontend/ui/scoreboard/scoreboard.dart';

class GameRepo {
  static GameRepo _instance;
  static GameRepo instance() {
    if (_instance == null) _instance = new GameRepo();
    return _instance;
  }

  Future<Paging<VwUserPoint>> fetchScoreboards(
      Map<String, String> query) async {
    try {
      final response = await MixUtil.get("/scoreboards", queries: query);

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        Paging<VwUserPoint> data = new Paging();
        data.fromJson(
            json,
            (json["data"] != null
                ? List.of(json["data"]).map((e) => VwUserPoint.fromJson(e)).toList()
                : null));
        return data;
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }


  Future<Paging<Submission>> fetchSubmissionHistories (int userId, Map<String, String> query) async {
    try {
      final response = await MixUtil.get("/users/$userId/submissions", queries: query);

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        Paging<Submission> data = new Paging();
        data.fromJson(
            json,
            (json["data"] != null
                ? List.of(json["data"]).map((e) => Submission.fromJson(e)).toList()
                : null));
        return data;
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }


  Future<Question> fetchNewQuestion () async {
    try {
      final response = await MixUtil.get("/new-questions");

      if (response.statusCode == 201) {
        Map<String, dynamic> json = jsonDecode(response.body);

        Question data = Question.fromJson(json["data"]);
        
        return data;
      } else {
        throw MixUtil.httpResponseToException(response);
      }
    } catch (e, s) {
      throw e;
    }
  }

  Future<Submission> saveSubmission (int userId, Submission data) async {
    try {
      Map<String, dynamic> body = {
        "question_id" : data.questionId,
        "answer" : data.answer
      };

      final response = await MixUtil.post("/users/$userId/submissions", body);

      if (response.statusCode == 201) {
        Map<String, dynamic> json = jsonDecode(response.body);

        Submission data = Submission.fromJson(json["data"]);

        return data;
      }
    } catch (e, s) {
      throw e;
    }
  }
  
}
