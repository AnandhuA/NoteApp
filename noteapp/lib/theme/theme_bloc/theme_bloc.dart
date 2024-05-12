import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/theme/colors.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(themeData: lightMode)) {
    on<ThemeChangeEvent>((event, emit) {
      if (event.themeData == darkMode) {
        emit(ThemeInitial(themeData: lightMode));
      } else if (event.themeData == lightMode) {
        emit(ThemeInitial(themeData: darkMode));
      }
    });
  }
}
