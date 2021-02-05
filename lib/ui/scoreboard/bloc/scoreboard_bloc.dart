import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:word_scramble_frontend/lib/model/paging.dart';
import 'package:word_scramble_frontend/lib/model/vw_user_point.dart';
import 'package:word_scramble_frontend/lib/repo/game_repo.dart';

part 'scoreboard_event.dart';
part 'scoreboard_state.dart';

class ScoreboardBloc extends Bloc<ScoreboardEvent, ScoreboardState> {
  ScoreboardBloc() : super(ScoreboardInitial());

  @override
  Stream<ScoreboardState> mapEventToState(
    ScoreboardEvent event,
  ) async* {
    ScoreboardState s = state;
    if (s is ErrorState) {
      s = (state as ErrorState).state;
    }
    if (event is FetchEvent) {
      if (s is FetchedState) {
        event.query["page"] = (s.page + 1).toString();
        Paging<VwUserPoint> datas =
            await GameRepo.instance().fetchScoreboards(event.query);

        yield new FetchedState(s.datas + datas.data, event.query,
            datas.currentPage, datas.currentPage == datas.lastPage);
      } else if (s is ScoreboardInitial) {
        event.query["page"] = "1";
        Paging<VwUserPoint> datas =
            await GameRepo.instance().fetchScoreboards(event.query);

        yield new FetchedState(datas.data, event.query, datas.currentPage,
            datas.currentPage == datas.lastPage);
      }
    } else if (event is RefreshEvent) {
      yield new ScoreboardInitial();
      this.add(FetchEvent(event.query));
    }
  }
}
