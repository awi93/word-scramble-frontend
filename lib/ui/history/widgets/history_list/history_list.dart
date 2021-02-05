import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/lib/auth/bloc/auth_bloc.dart';
import 'package:word_scramble_frontend/lib/model/submission.dart';
import 'package:word_scramble_frontend/ui/history/widgets/history_list/bloc/history_list_bloc.dart';

class HistoryList extends StatefulWidget {

  _HistoryList createState() => _HistoryList();

}

class _HistoryList extends State<HistoryList> {

  HistoryListBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bloc = HistoryListBloc();
    if (BlocProvider.of<AuthBloc>(context).state is AuthenticatedState) {
      AuthenticatedState s = BlocProvider.of<AuthBloc>(context).state;
      _bloc.add(FetchHistoryEvent(s.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.lightBlue,
              child: Center(
                child: Text(
                  "Submission History",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: BlocBuilder(
                  cubit: _bloc,
                  builder: (context, state) {
                    if (state is HistoryListInitial) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is HistoryFetchedState) {
                      if (state.datas.length > 0) {
                        return ListView.separated(
                          itemCount: state.datas.length,
                          itemBuilder: (context, index) {
                            if (state.datas[index].isTrue) {
                              return CorrectSubmission(state.datas[index]);
                            }
                            return WrongSubmission(state.datas[index]);
                          },
                          separatorBuilder: (context, index) {
                            return Container(height: 10);
                          },
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Image(
                                image: AssetImage("assets/be_the_first.png"),
                              ),
                            ),
                            Container(height: 10,),
                            Text(
                              "Be the first !!!",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 24
                              ),
                            )
                          ],
                        );
                      }
                    }

                    return Container();
                  },
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}

class CorrectSubmission extends StatelessWidget {

  Submission data;

  CorrectSubmission(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              flex: 80,
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "QUESTION",
                        style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey
                        ),
                      ),
                      Text(
                        data.question.scrambled,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "YOUR ANSWER",
                        style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey
                        ),
                      ),
                      Text(
                        data.answer,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CORRENT ANSWER",
                        style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey
                        ),
                      ),
                      Text(
                        data.question.word.word,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 20,
              child: Column(
                children: [
                  Text("POINT"),
                  Text(
                    data.point.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius : BorderRadius.circular(10),
        border : Border.all(color: Colors.green, width: 5)
      ),
    );
  }
}

class WrongSubmission extends StatelessWidget {

  Submission data;

  WrongSubmission(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              flex: 80,
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "QUESTION",
                        style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey
                        ),
                      ),
                      Text(
                        data.question.scrambled,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "YOUR ANSWER",
                        style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey
                        ),
                      ),
                      Text(
                        data.answer,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CORRENT ANSWER",
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey
                        ),
                      ),
                      Text(
                        data.question.word.word,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 20,
              child: Column(
                children: [
                  Text("POINT"),
                  Text(
                    data.point.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          border : Border.all(color: Colors.red, width: 5)
      ),
    );
  }
}