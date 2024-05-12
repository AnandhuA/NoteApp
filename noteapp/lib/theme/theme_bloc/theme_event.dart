part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class ThemeChangeEvent extends ThemeEvent {
  final ThemeData themeData;

  ThemeChangeEvent({required this.themeData});
}
