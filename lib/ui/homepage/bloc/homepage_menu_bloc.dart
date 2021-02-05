import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'homepage_menu_event.dart';
part 'homepage_menu_state.dart';

class HomepageMenuBloc extends Bloc<HomepageMenuEvent, HomepageMenuState> {
  HomepageMenuBloc() : super(HomepageState());

  @override
  Stream<HomepageMenuState> mapEventToState(
    HomepageMenuEvent event,
  ) async* {
    if (event is HomepageEvent) {
      yield new HomepageState();
    } else if (event is PlayEvent) {
      yield new PlayState();
    } else if (event is HistoryEvent) {
      yield new HistoryState();
    }
  }
}
