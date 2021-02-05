part of 'history_list_bloc.dart';

@immutable
abstract class HistoryListEvent {}

class FetchHistoryEvent extends HistoryListEvent {

  int userId;

  FetchHistoryEvent(this.userId);

}