import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/api/api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<AddButtonNavigate>(addButtonNavigate);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    // final List list = await getAllNotes();
    emit(HomeSuccessState(noteList: []));
    // print(list);
  }

  FutureOr<void> addButtonNavigate(
      AddButtonNavigate event, Emitter<HomeState> emit) {
    emit(NavegateToAddNotePage());
  }
}
