import 'package:flutter/material.dart';
import 'package:noteapp/screens/add_note_screen.dart';
import 'package:noteapp/widgets/note_widegt.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        title: const Text(
          "Notes",
        ),
      ),
      body: const NoteWidget(),
    );
  }
}
