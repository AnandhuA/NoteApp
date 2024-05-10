import 'package:flutter/material.dart';
import 'package:noteapp/api/api.dart';
import 'package:noteapp/screens/add_note_screen.dart';

import 'package:noteapp/screens/widgets/note_widegt.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.grid_3x3)),
          const SizedBox(width: 10),
        ],
      ),
      body: NoteWidget(notesList: notes),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade400,
        onPressed: () {
          print("object");
          
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
