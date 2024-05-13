import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:noteapp/bloc/note_bloc.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/screens/add_note_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/screens/widgets/note_widegt.dart';
import 'package:noteapp/theme/colors.dart';
import 'package:noteapp/theme/theme_bloc/theme_bloc.dart';
import 'package:noteapp/ui_change_bloc/ui_change_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(ApiCallingEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          BlocBuilder<UiChangeBloc, UiChangeState>(
            builder: (context, state) {
              final uiState = state is UiChangeInitial ? state.uiState : false;
              return IconButton(
                onPressed: () {
                  context.read<UiChangeBloc>().add(UiChangeButtonEvent());
                },
                icon: Icon(uiState ? Icons.grid_4x4 : Icons.grid_3x3),
              );
            },
          ),
          IconButton(
            onPressed: () {
              if (isdarkMode) {
                context
                    .read<ThemeBloc>()
                    .add(ThemeChangeEvent(themeData: darkMode));
                isdarkMode = false;
              } else {
                context
                    .read<ThemeBloc>()
                    .add(ThemeChangeEvent(themeData: lightMode));
                isdarkMode = true;
              }
            },
            icon: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                if (state is ThemeInitial) {
                  if (state.themeData == darkMode) {
                    return const Icon(
                      Icons.light_mode_outlined,
                    );
                  } else if (state.themeData == lightMode) {
                    return const Icon(
                      Icons.dark_mode_outlined,
                    );
                  }
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ScuccessState) {
            return state.notes.isEmpty
                ? Center(
                    child:
                        Lottie.asset('assets/Animation - 1715440391123.json'),
                  )
                : NoteWidget(notesList: state.notes);
          }
          if (state is ErrorState) {
            return Center(
              child: Lottie.asset("assets/Animation - 1715440862032.json"),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade400,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNoteScreen(),
              ));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
