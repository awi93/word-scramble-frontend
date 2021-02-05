import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:word_scramble_frontend/lib/model/question.dart';
import 'package:word_scramble_frontend/lib/repo/game_repo.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayInitial());

  @override
  Stream<PlayState> mapEventToState(
    PlayEvent event,
  ) async* {
    if (event is GeneratePlayEvent) {
      try {
        yield new PlayInitial();
        Question data = await GameRepo.instance().fetchNewQuestion();
        yield new PlayGenerated(data);
      } catch (e) {
        yield new FailToGenerated();
      }
    }
  }
}
