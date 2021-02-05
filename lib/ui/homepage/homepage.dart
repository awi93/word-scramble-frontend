import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/lib/auth/bloc/auth_bloc.dart';
import 'package:word_scramble_frontend/ui/history/history.dart';
import 'package:word_scramble_frontend/ui/homepage/bloc/homepage_menu_bloc.dart';
import 'package:word_scramble_frontend/ui/play/play.dart';
import 'package:word_scramble_frontend/ui/scoreboard/scoreboard.dart';

class Homepage extends StatefulWidget {
  @override
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  HomepageMenuBloc _bloc;

  void initState() {
    super.initState();

    _bloc = new HomepageMenuBloc();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Word Scramble"),
            ),
            body: buildBody(),
            bottomNavigationBar: BlocBuilder(
              cubit: _bloc,
              builder: (BuildContext context, HomepageMenuState state) {
                return BottomNavigationBar(
                    currentIndex: state.currentIndex,
                    elevation: 10,
                    type: BottomNavigationBarType.fixed,
                    onTap: (int tabIndex) {
                      if (state.currentIndex == tabIndex) {
                        return;
                      }
                      switch (tabIndex) {
                        case 0:
                          _bloc.add(HomepageEvent());
                          break;
                        case 1:
                          if (BlocProvider.of<AuthBloc>(context).state
                              is AuthenticatedState)
                            _bloc.add(PlayEvent());
                          else
                            Navigator.of(context).pushNamed("/login");
                          break;
                        case 2:
                          if (BlocProvider.of<AuthBloc>(context).state
                              is AuthenticatedState)
                            _bloc.add(HistoryEvent());
                          else
                            Navigator.of(context).pushNamed("/login");
                          break;
                      }
                    },
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: "Scoreboard"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.play_arrow), label: "Play"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.history), label: "History")
                    ]);
              },
            )));
  }

  Widget buildBody() {
    return BlocBuilder(
      cubit: _bloc,
      builder: (context, state) {
        if (state is HomepageState) {
          return Scoreboard();
        } else if (state is PlayState) {
          return Play();
        } else if (state is HistoryState) {
          return History();
        }
        return Container();
      },
    );
  }
}
