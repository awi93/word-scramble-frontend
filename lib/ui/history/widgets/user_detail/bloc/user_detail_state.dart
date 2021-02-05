part of 'user_detail_bloc.dart';

@immutable
abstract class UserDetailState {}

class UserDetailInitial extends UserDetailState {}

class UserDetailFetched extends UserDetailState {

  VwUserPoint data;

  UserDetailFetched(this.data);
}

class FailToFetchState extends UserDetailState {}