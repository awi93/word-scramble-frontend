part of 'scoreboard_bloc.dart';

@immutable
abstract class ScoreboardEvent {}

class FetchEvent extends ScoreboardEvent {
  Map<String, String> query;
  FetchEvent(this.query);
}

class RefreshEvent extends ScoreboardEvent {
  Map<String, String> query;

  RefreshEvent(this.query);
}
