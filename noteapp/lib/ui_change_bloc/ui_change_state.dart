part of 'ui_change_bloc.dart';

@immutable
sealed class UiChangeState {}

final class UiChangeInitial extends UiChangeState {
  final bool uiState;

  UiChangeInitial({required this.uiState});
}
