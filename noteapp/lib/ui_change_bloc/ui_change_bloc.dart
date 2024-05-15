import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/theme/colors.dart';

part 'ui_change_event.dart';
part 'ui_change_state.dart';

class UiChangeBloc extends Bloc<UiChangeEvent, UiChangeState> {
  UiChangeBloc()
      : super(UiChangeInitial(uiState: false, themeData: lightMode)) {
    on<UiChangeButtonEvent>((event, emit) {
      if (state is UiChangeInitial) {
        final newUiState = !(state as UiChangeInitial).uiState;
        emit(UiChangeInitial(
          uiState: newUiState,
          themeData: (state as UiChangeInitial).themeData,
        ));
      }
    });
  }
}
