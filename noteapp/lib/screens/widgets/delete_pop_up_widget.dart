// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class DeletePopUpWidget extends StatelessWidget {
  final int index;
  const DeletePopUpWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        // "Delete ${notes[index]["title"]}",
        "",
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
            // await deleteNote(notes[index]);
          },
          child: const Text("Yes"),
        )
      ],
    );
  }
}
