import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:word_scramble_frontend/lib/model/submission.dart';
import 'package:word_scramble_frontend/lib/repo/game_repo.dart';

part 'submission_event.dart';
part 'submission_state.dart';

class SubmissionBloc extends Bloc<SubmissionEvent, SubmissionState> {
  SubmissionBloc() : super(SubmissionInitial());

  @override
  Stream<SubmissionState> mapEventToState(
    SubmissionEvent event,
  ) async* {
    if (event is SubmitAnswerEvent) {
      try {
        yield new SubmittingState(event.userId, event.data);
        Submission data = await GameRepo.instance().saveSubmission(event.userId, event.data);
        yield new SuccessSubmitedState(data);
      }
      catch (e) {
        yield new FailToSubmitState(event);
      }
    }
    else if (event is TryAgainEvent) {
      yield new SubmissionInitial();
    }
  }
}
