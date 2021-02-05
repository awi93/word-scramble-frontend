part of 'submission_bloc.dart';

@immutable
abstract class SubmissionState {}

class SubmissionInitial extends SubmissionState {}

class SubmittingState extends SubmissionState {

  int userId;
  Submission data;

  SubmittingState(this.userId, this.data);
}

class SuccessSubmitedState extends SubmissionState {

  Submission data;

  SuccessSubmitedState(this.data);

}

class FailToSubmitState extends SubmissionState {

  SubmissionEvent event;

  FailToSubmitState(this.event);
}