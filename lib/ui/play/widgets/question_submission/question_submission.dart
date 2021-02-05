import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/lib/model/question.dart';
import 'package:word_scramble_frontend/lib/model/submission.dart';
import 'package:word_scramble_frontend/lib/repo/auth_repo.dart';
import 'package:word_scramble_frontend/ui/play/bloc/play_bloc.dart';
import 'package:word_scramble_frontend/ui/play/widgets/question_submission/bloc/submission_bloc.dart';

class QuestionSubmission extends StatefulWidget {

  Question data;

  QuestionSubmission(this.data);

  @override
  _QuestionSubmission createState() => _QuestionSubmission(data);

}

class _QuestionSubmission extends State<QuestionSubmission> {

  Question data;

  List<String> question;
  Map<String, String> answer;

  PlayBloc _playBloc;
  SubmissionBloc _bloc;

  _QuestionSubmission(this.data);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _playBloc = BlocProvider.of<PlayBloc>(context);
    _bloc = new SubmissionBloc();

    question = this.data.scrambled.split("");
    answer = new Map();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _bloc,
      builder: (context, state) {
        if (state is SubmissionInitial) {
          return buildQuiz();
        } else if (state is SubmittingState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Submitting Your Answer ....")
            ],
          );
        } else if (state is SuccessSubmitedState) {
          if (state.data.isTrue) {
            return buildCorrectAnswer(state.data);
          } else {
            return buildWrongAnswer(state.data);
          }
        } else if (state is FailToSubmitState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Fail to submit your answer"),
              Container(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  _bloc.add(state.event);
                },
                child: Text(
                  "Try Again"
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget buildCorrectAnswer (Submission data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Image(
              image: AssetImage(
                  "assets/correct_anwer.png"
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Text(
            "Hore !!!!! Your Answer is corrent",
            style: TextStyle(
              color: Colors.green,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 10,
          ),
          Text(
            "You got " + data.point.toString() + " point!!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 10,
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                _playBloc.add(GeneratePlayEvent());
              },
              color: Colors.green,
              child: Text(
                  "Continue ..."
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildWrongAnswer (Submission data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Image(
              image: AssetImage(
                  "assets/wrong_answer.png"
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Text(
            "Booo... You answer is wrong",
            style: TextStyle(
                color: Colors.green,
                fontSize: 30
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 10,
          ),
          Text(
            "Your point deducted by " + data.point.abs().toString() + " point..",
            style: TextStyle(
                color: Colors.black,
                fontSize: 40
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex:50,
                child: Container(
                  height: 70,
                  child: RaisedButton(
                    onPressed: () {
                      _bloc.add(TryAgainEvent());
                    },
                    color: Colors.red,
                    child: Text(
                      "Try Again"
                    ),
                  ),
                ),
              ),
              Container(
                width: 10,
              ),
              Expanded(
                flex:50,
                child: Container(
                  height: 70,
                  child: RaisedButton(
                    onPressed: () {
                      _playBloc.add(GeneratePlayEvent());
                    },
                    color: Colors.green,
                    child: Text(
                        "Refresh Question"
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildQuiz () {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 30
              ),
              alignment: Alignment.center,
              child: Wrap(
                children: buildAnswer(),
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 10,
                spacing: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Wrap(
                children: buildQuestion(),
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 10,
                spacing: 10,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: RaisedButton(
                  onPressed: answer.length == question.length ? () {
                    submitAnswer();
                  } : null,
                  child: Text(
                    "Submit Answer"
                  ),
                  color: Colors.amber,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildAnswer() {
    List<Widget> widgets = [];
    List<String> tmpAns = answer.values.toList();
    List<String> tmpKeys = answer.keys.toList();
    for (int i = 0; i < question.length; i ++) {
      widgets.add(Container(
        width: MediaQuery.of(context).size.width/10,
        child: AspectRatio(
          aspectRatio: 3/4,
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    (i < tmpAns.length) ? tmpAns[i] : "",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (i == (tmpAns.length-1)) {
                      return Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              answer.remove(tmpKeys[i]);
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  List<Widget> buildQuestion() {
    List<Widget> widgets = [];
    for (int i=0;i<question.length;i++) {
      widgets.add(GestureDetector(
        onTap: () {
          if (!answer.containsKey(question[i]+"_"+i.toString())) {
            setState(() {
              this.answer[question[i]+"_"+i.toString()] = question[i];
            });
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width/10,
          child: AspectRatio(
            aspectRatio: 3/4,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                question[i],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (answer.containsKey(question[i]+"_"+i.toString())) ? Colors.blue[200] : Colors.blue
              ),
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  void submitAnswer() {
    String answrs = answer.values.join("").toUpperCase();
    Submission data = new Submission();
    data.userId = AuthRepo().getUser().id;
    data.questionId = this.data.id;
    data.answer = answrs;
    _bloc.add(SubmitAnswerEvent(data.userId, data));
  }

}