import 'package:flutter/material.dart';
import 'package:noteapp/api/api.dart';
import 'package:noteapp/colors/colors.dart';
import 'package:noteapp/screens/add_note_screen.dart';

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
            return note(index: index, context: context);
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
        color: colors[index % colors.length],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notes.value[index]["title"],
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
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
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Text(
              notes.value[index]["content"],
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
