import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/ui/play/bloc/play_bloc.dart';
import 'package:word_scramble_frontend/ui/play/widgets/question_submission/question_submission.dart';

class Play extends StatefulWidget {
  _Play createState() => _Play();
}

class _Play extends State<Play> {
  PlayBloc _bloc;


  @override
  void initState() {
    super.initState();

    _bloc = PlayBloc();
    _bloc.add(GeneratePlayEvent());
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder(
        cubit: _bloc,
        builder: (context, state) {
          if (state is PlayInitial) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
            );
          }
          else if (state is FailToGenerated) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "Fail to generate game"
                        ),
                        Container(
                          height: 10,
                        ),
                        RaisedButton(
                          onPressed: () {
                            _bloc.add(GeneratePlayEvent());
                          },
                          child: Text(
                              "Try Again"
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          else if (state is PlayGenerated) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Make Your Guest",
                            style: TextStyle(
                                fontSize: 30
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              onPressed: () {
                                _bloc.add(GeneratePlayEvent());
                              },
                              child: Text(
                                  "Refresh Question"
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Expanded(
                    child: QuestionSubmission(state.data),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      )
    );
  }
}
