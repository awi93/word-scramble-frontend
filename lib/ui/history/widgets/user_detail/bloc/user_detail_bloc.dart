import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:word_scramble_frontend/lib/model/vw_user_point.dart';
import 'package:word_scramble_frontend/lib/repo/user_repo.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc() : super(UserDetailInitial());

  @override
  Stream<UserDetailState> mapEventToState(
    UserDetailEvent event,
  ) async* {
    if (event is FetchUserDetailEvent) {
      try {
        VwUserPoint data = await UserRepo.instance().fetchPoint(event.userId);
        yield new UserDetailFetched(data);
      }
      catch (e) {
        yield new FailToFetchState();
      }
    }
  }
}
