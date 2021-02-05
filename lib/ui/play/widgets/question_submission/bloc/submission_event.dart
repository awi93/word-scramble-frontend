part of 'submission_bloc.dart';

@immutable
abstract class SubmissionEvent {}

class SubmitAnswerEvent extends SubmissionEvent {

  int userId;
  Submission data;

  SubmitAnswerEvent(this.userId, this.data);
}

class TryAgainEvent extends SubmissionEvent {}