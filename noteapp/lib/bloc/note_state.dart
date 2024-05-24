part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class LoadingState extends NoteState {}

final class ScuccessState extends NoteState {
  final List notes;
  final bool add;

  ScuccessState({required this.notes, this.add = true});
}

final class ErrorState extends NoteState {
  final String errorMessage;

  ErrorState({
    required this.errorMessage,
  });
}

