part of 'homepage_menu_bloc.dart';

@immutable
abstract class HomepageMenuEvent {}

class HomepageEvent extends HomepageMenuEvent {}

class PlayEvent extends HomepageMenuEvent {}

class HistoryEvent extends HomepageMenuEvent {}
