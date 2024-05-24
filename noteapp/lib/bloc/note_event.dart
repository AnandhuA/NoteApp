part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

class GetallNotesEvent extends NoteEvent {}

class NoteAddEvent extends NoteEvent {
  final String title;
  final String content;

  NoteAddEvent({
    required this.title,
    required this.content,
  });
}

class NoteEditEvent extends NoteEvent {
  final int id;
  final String title;
  final String content;

  NoteEditEvent({
    required this.title,
    required this.content,
    required this.id,
  });
}

class NoteDeleteEvent extends NoteEvent {
  final Map note;

  NoteDeleteEvent({
    required this.note,
  });
}
