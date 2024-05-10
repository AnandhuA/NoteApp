import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'bloc_event.dart';
part 'bloc_state.dart';

List blocList = [];
const baseUrl = "http://192.168.66.242:3000/";

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(BlocInitialState()) {
    on<BlocApiRequest>((event, emit) async {
      emit(BlocLoadingState());
      try {
        final req = await http.get(
          Uri.parse("${baseUrl}getAllNotes"),
        );
        //  List<NoteModel> listOfNotes =
        //      ( jsonDecode(req.body) as List).map((noteJson) {
        //     return NoteModel(
        //       id: noteJson['id'],
        //       title: noteJson['title'],
        //       content: noteJson['content'],
        //       date: noteJson['date'],
        //     );
        //   }).toList();

        //   return BlocSuccessState(listofNotes:  listOfNotes);
        print("okk");

        return emit(BlocSuccessState(listofNotes: await jsonDecode(req.body)));
      } catch (e) {
        debugPrint(e.toString());
        return emit(BlocErrorState());
      }
    });
  }
}
