part of 'user_detail_bloc.dart';

@immutable
abstract class UserDetailEvent {}

class FetchUserDetailEvent extends UserDetailEvent {

  int userId;
  FetchUserDetailEvent(this.userId);
}