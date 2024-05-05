part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class AddButtonNavigate extends HomeEvent {}

class ViewNoteNavigate extends HomeEvent {
  final note;

  ViewNoteNavigate({this.note});
}

class NoteLongpress extends HomeEvent {}
