import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_scramble_frontend/lib/error/error_type.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

part 'init_event.dart';
part 'init_state.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  InitBloc() : super(InitInitial());

  @override
  Stream<InitState> mapEventToState(
    InitEvent event,
  ) async* {
    if (event is InitAppsEvent) {
      try {
        yield new InitInitial();
        await MixUtil.setupHttpClient();
        await MixUtil.setupPreferences();
        yield new InitializedState();
      } catch (e) {
        yield new FailToInitState(ErrorType.CONNECTION_ERROR, null);
      }
    }
  }
}
