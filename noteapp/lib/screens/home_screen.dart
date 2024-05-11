import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:noteapp/bloc/note_bloc.dart';
import 'package:noteapp/screens/add_note_screen.dart';

import 'package:noteapp/screens/widgets/note_widegt.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(ApiCallingEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      
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
             return NoteWidget(notesList: state.notes);
             
        
          }
          if (state is ErrorState) {
            return const Center(
              child: Text("Error"),
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
