import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:word_scramble_frontend/lib/model/paging.dart';
import 'package:word_scramble_frontend/lib/model/submission.dart';
import 'package:word_scramble_frontend/lib/repo/game_repo.dart';

part 'history_list_event.dart';
part 'history_list_state.dart';

class HistoryListBloc extends Bloc<HistoryListEvent, HistoryListState> {
  HistoryListBloc() : super(HistoryListInitial());

  @override
  Stream<HistoryListState> mapEventToState(
    HistoryListEvent event,
  ) async* {
    if (event is FetchHistoryEvent) {
      try {
        yield new HistoryListInitial();
        Map<String, String> query = {
          "order_by": "[created_at:DESC]"
        };
        Paging<Submission> datas = await GameRepo.instance()
            .fetchSubmissionHistories(event.userId, query);
        yield new HistoryFetchedState(datas.data);
      } catch (e) {
        yield new FailToFetchState();
      }
    }
  }
}
