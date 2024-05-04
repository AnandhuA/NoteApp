part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class AddButtonNavigate extends HomeEvent{} 

class ViewNoteNavigate extends HomeEvent{}

class NoteLongpress extends HomeEvent{}

