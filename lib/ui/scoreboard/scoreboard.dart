import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/lib/model/vw_user_point.dart';
import 'package:word_scramble_frontend/ui/scoreboard/bloc/scoreboard_bloc.dart';

class Scoreboard extends StatefulWidget {
  @override
  _Scoreboard createState() => _Scoreboard();
}

class _Scoreboard extends State<Scoreboard> {
  ScoreboardBloc _bloc;
  Map<String, String> query = {"paging": "10"};

  @override
  void initState() {
    _bloc = new ScoreboardBloc();
    _bloc.add(FetchEvent(query));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        borderOnForeground: true,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.lightBlue,
              child: Center(
                child: Text(
                  "Scoreboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder(
                cubit: _bloc,
                builder: (context, state) {
                  if (state is FetchedState) {
                    if (state.datas.length > 0) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: ListView.separated(
                          itemCount: state.datas.length,
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0 :
                                return FirstPost(index + 1, state.datas[index]);
                              case 1 :
                                return SecondPost(index + 1, state.datas[index]);
                              case 2 :
                                return ThirdPost(index + 1, state.datas[index]);
                              default :
                                return OtherPost(index + 1, state.datas[index]);
                            }
                          },
                          primary: true,
                        ),
                      );
                    }
                    else {
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
                  } else if (state is ScoreboardInitial) {
                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}

class FirstPost extends StatelessWidget {

  int rank;
  VwUserPoint data;

  FirstPost(this.rank, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 20,
            child: Text(
              rank.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Column(
              children: [
                Text(
                  data.user.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: [
                Text(
                  data.point.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }

}

class SecondPost extends StatelessWidget {

  int rank;
  VwUserPoint data;

  SecondPost(this.rank, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 20,
            child: Text(
              rank.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Column(
              children: [
                Text(
                  data.user.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: [
                Text(
                  data.point.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xFFC0C0C0),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }

}

class ThirdPost extends StatelessWidget {

  int rank;
  VwUserPoint data;

  ThirdPost(this.rank, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 20,
            child: Text(
              rank.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Column(
              children: [
                Text(
                  data.user.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: [
                Text(
                  data.point.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }

}

class OtherPost extends StatelessWidget {

  int rank;
  VwUserPoint data;

  OtherPost(this.rank, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 20,
            child: Text(
              rank.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Column(
              children: [
                Text(
                  data.user.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: [
                Text(
                  data.point.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }

}