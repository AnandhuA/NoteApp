import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/screens/add_note/add_note_screen.dart';
import 'package:noteapp/screens/home/home_bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    homeBloc.add(HomeInitialEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is NavegateToAddNotePage) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNoteScreen(),
              ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case const (HomeSuccessState):
            return Scaffold(
              appBar: AppBar(
                title: const Text("Notes"),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue.shade400,
                onPressed: () {
                  homeBloc.add(AddButtonNavigate());
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
            );
          case const (HomeErrorState):
            return const Scaffold(
              body: Center(child: Text("error")),
            );
          default:
            return const SizedBox();
        }
      },
    );

    // Scaffold(

    //   appBar: AppBar(
    //     title: const Text(
    //       "Notes",
    //     ),
    //     actions: [
    //       IconButton(
    //         onPressed: () {
    //           context.read<UiChangeBlocBloc>().add(UiChange());
    //         },
    //         icon: BlocBuilder<UiChangeBlocBloc, UiChangeBlocState>(
    //           builder: (context, state) {
    //             return state.grid
    //                 ? const Icon(Icons.grid_3x3)
    //                 : const Icon(Icons.grid_4x4);
    //           },
    //         ),
    //       ),
    //       const SizedBox(width: 10),
    //     ],
    //   ),
    //   body: const NoteWidget(),
    // );
  }
}
