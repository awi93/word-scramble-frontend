part of 'history_list_bloc.dart';

@immutable
abstract class HistoryListState {}

class HistoryListInitial extends HistoryListState {}

class HistoryFetchedState extends HistoryListState {

  List<Submission> datas;

  HistoryFetchedState(this.datas);
}

class FailToFetchState extends HistoryListState {}