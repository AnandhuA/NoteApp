// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/bloc/note_bloc.dart';

import 'package:noteapp/colors/colors.dart';

import 'package:noteapp/screens/view_note_screen.dart';
import 'package:noteapp/screens/widgets/delete_pop_up_widget.dart';

class NoteWidget extends StatelessWidget {
  final List notesList;

  const NoteWidget({super.key, required this.notesList});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: notesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 4.5,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.white,
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => DeletePopUpWidget(
                    note: notesList[index],
                  ),
                );
              },
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNoteScreen(
                      note: notesList[index],
                    ),
                  )),
              child: note(
                note: notesList[index],
                context: context,
              ),
            );
          },
        );
      },
    );
  }
}

Widget note({
  required Map note,
  required BuildContext context,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: colors[note["id"] % colors.length],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          note["title"] ?? "null",
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 20,
          ),
        ),
        Expanded(
          child: Text(
            note["content"] ?? "null",
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        )
      ],
    ),
  );
}
