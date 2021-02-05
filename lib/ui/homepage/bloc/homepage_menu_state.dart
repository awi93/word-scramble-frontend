part of 'homepage_menu_bloc.dart';

@immutable
abstract class HomepageMenuState {
  int currentIndex;
}

class HomepageState extends HomepageMenuState {
  HomepageState() {
    this.currentIndex = 0;
  }
}

class PlayState extends HomepageMenuState {
  PlayState() {
    this.currentIndex = 1;
  }
}

class HistoryState extends HomepageMenuState {
  HistoryState() {
    this.currentIndex = 2;
  }
}
