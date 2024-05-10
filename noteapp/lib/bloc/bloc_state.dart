part of 'bloc_bloc.dart';

@immutable
sealed class BlocState {}

final class BlocInitialState extends BlocState {
  
}

final class BlocSuccessState extends BlocState {
  final List listofNotes;

  BlocSuccessState({required this.listofNotes});
  
}

final class BlocLoadingState extends BlocState {}

final class BlocErrorState extends BlocState {}
