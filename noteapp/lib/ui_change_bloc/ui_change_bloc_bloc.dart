import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ui_change_bloc_event.dart';
part 'ui_change_bloc_state.dart';

class UiChangeBlocBloc extends Bloc<UiChangeBlocEvent, UiChangeBlocState> {
  UiChangeBlocBloc() : super(UiChangeBlocInitial()) {
    on<UiChange>((event, emit) {
      if (state.grid == false) {
        return emit(UiChangeBlocState(grid: state.grid = true));
      } else {
        return emit(UiChangeBlocState(grid: state.grid = false));
      }
    });
  }
}
