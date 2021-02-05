part of 'play_bloc.dart';

@immutable
abstract class PlayState {}

class PlayInitial extends PlayState {}

class PlayGenerated extends PlayState {

  Question data;

  PlayGenerated(this.data);

}

class FailToGenerated extends PlayState {}