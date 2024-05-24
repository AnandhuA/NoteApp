// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/bloc/note_bloc.dart';

class DeletePopUpWidget extends StatelessWidget {
  final Map note;
  const DeletePopUpWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Delete ${note["title"]}",
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              content: const Text(
                "Deleted",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.green[200],
            ));
            context.read<NoteBloc>().add(NoteDeleteEvent(note: note));
          },
          child: const Text("Yes"),
        )
      ],
    );
  }
}
