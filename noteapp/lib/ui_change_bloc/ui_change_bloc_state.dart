part of 'ui_change_bloc_bloc.dart';

class UiChangeBlocState {
  bool grid;

  UiChangeBlocState({required this.grid});
}

final class UiChangeBlocInitial extends UiChangeBlocState {

  UiChangeBlocInitial():super(grid: true);
  
}
