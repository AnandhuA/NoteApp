part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {
  final ThemeData themeData;

  ThemeInitial({required this.themeData});
}


