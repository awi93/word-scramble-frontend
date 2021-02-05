part of 'scoreboard_bloc.dart';

@immutable
abstract class ScoreboardState {}

class ScoreboardInitial extends ScoreboardState {}

class FetchedState extends ScoreboardState {
  List<VwUserPoint> datas;
  Map<String, String> query;
  int page;
  bool isFinished;

  FetchedState(this.datas, this.query, this.page, this.isFinished);
}

class ErrorState extends ScoreboardState {
  ScoreboardEvent event;
  ScoreboardState state;
  ErrorState(this.state, this.event);
}
