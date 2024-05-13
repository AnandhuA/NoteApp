import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'note_event.dart';
part 'note_state.dart';

const baseUrl = "http://192.168.66.246:3000/";

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<ApiCallingEvent>(_apiCallingEvent);
    on<NoteAddEvent>(_noteAddEvent);
    on<NoteEditEvent>(_noteEditEvent);
    on<NoteDeleteEvent>(_noteDeleteEvent);
  }

  FutureOr<void> _apiCallingEvent(
    ApiCallingEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(LoadingState());
    try {
 
      final req = await http.get(
        Uri.parse("${baseUrl}getAllNotes"),
      );
      List noteList = await jsonDecode(req.body);
  
      emit(ScuccessState(notes: noteList));
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _noteAddEvent(
    NoteAddEvent event,
    Emitter<NoteState> emit,
  ) async {
    if (event.content.isEmpty || event.title.isEmpty) {
      return emit(ErrorState(errorMessage: "Empty Fields"));
    }
    Map<String, dynamic> jsonData = {
      'id': DateTime.now().microsecondsSinceEpoch,
      'title': event.title,
      'content': event.content,
      'date': DateTime.now().toString(),
    };
    emit(LoadingState());

    try {
      final res = await http.post(
        Uri.parse("${baseUrl}addNode"),
        body: jsonEncode(jsonData),
        headers: {"Content-Type": "application/json"},
      );

      if (res.statusCode == 200) {
        List noteList = await jsonDecode(res.body);
        emit(ScuccessState(notes: noteList));
      } else {
        emit(ErrorState(errorMessage: "Server not Responding"));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _noteEditEvent(
    NoteEditEvent event,
    Emitter<NoteState> emit,
  ) async {
    Map<String, dynamic> jsonData = {
      'id': event.id,
      'title': event.title,
      'content': event.content,
      'date': DateTime.now().toString(),
    };
    emit(LoadingState());
    try {
      final res = await http.post(
        Uri.parse("${baseUrl}updateNote/${event.id}"),
        body: jsonEncode(jsonData),
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        List noteList = await jsonDecode(res.body);
        emit(ScuccessState(
          notes: noteList,
          add: false,
        ));
      } else {
        emit(ErrorState(errorMessage: "Server not Responding"));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _noteDeleteEvent(
      NoteDeleteEvent event, Emitter<NoteState> emit) async {
    emit(LoadingState());
    try {
      final res = await http.post(
        Uri.parse("${baseUrl}deleteNote/${event.note["id"]}"),
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        List noteList = await jsonDecode(res.body);
        emit(ScuccessState(
          notes: noteList,
          add: false,
        ));
      } else {
        emit(ErrorState(errorMessage: "Server not Responding"));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
