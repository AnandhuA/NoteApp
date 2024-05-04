// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/api/api.dart';
import 'package:noteapp/screens/add_note/add_note_screen.dart';

class ViewNoteScreen extends StatelessWidget {
  final int index;
  const ViewNoteScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(notes.value[index]["date"]);
    final date = DateFormat('dd MMM yyyy').format(dateTime);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNoteScreen(
                    add: false,
                    title: notes.value[index]["title"],
                    description: notes.value[index]["content"],
                    id: notes.value[index]["id"],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit_note_sharp),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: notes,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [const Spacer(), Text(date)],
                  ),
                  Text(
                    notes.value[index]["title"] ?? "null",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    notes.value[index]["content"] ?? "null",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
