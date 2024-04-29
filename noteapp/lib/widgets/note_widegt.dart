// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:noteapp/api/api.dart';
import 'package:noteapp/colors/colors.dart';
import 'package:noteapp/screens/view_note_screen.dart';
import 'package:noteapp/widgets/delete_pop_up_widget.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notes,
      builder: (context, value, child) {
        return GridView.builder(
          itemCount: notes.value.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.white,
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => DeletePopUpWidget(index: index),
                );
              },
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNoteScreen(
                      index: index,
                    ),
                  )),
              child: note(index: index, context: context),
            );
          },
        );
      },
    );
  }

  Widget note({required int index, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors[notes.value[index]["id"] % colors.length],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              notes.value[index]["title"] ?? "null",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Text(
              notes.value[index]["content"] ?? "null",
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
