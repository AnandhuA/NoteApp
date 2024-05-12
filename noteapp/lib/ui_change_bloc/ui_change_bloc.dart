import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'ui_change_event.dart';
part 'ui_change_state.dart';

class UiChangeBloc extends Bloc<UiChangeEvent, UiChangeState> {
  UiChangeBloc() : super(UiChangeInitial(uiState: true)) {
    on<UiChangeButtonEvent>((event, emit) {
      
    });
  }
}
