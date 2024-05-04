part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List noteList;

  HomeSuccessState({required this.noteList});
}

class HomeErrorState extends HomeState {}

class NavegateToAddNotePage extends HomeActionState {}
