// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:noteapp/api/api.dart';
import 'package:noteapp/colors/colors.dart';
import 'package:noteapp/screens/view_note/view_note_screen.dart';
import 'package:noteapp/ui_change_bloc/ui_change_bloc_bloc.dart';
import 'package:noteapp/screens/widgets/delete_pop_up_widget.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notes,
      builder: (context, value, child) {
        return BlocBuilder<UiChangeBlocBloc, UiChangeBlocState>(
          builder: (context, state) {
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: notes.value.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: state.grid ? 3.5 : 1,
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
                  child: note(
                    index: index,
                    context: context,
                    state: state.grid,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget note({
    required int index,
    required BuildContext context,
    required bool state,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors[notes.value[index]["id"] % colors.length],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notes.value[index]["title"] ?? "null",
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 20,
            ),
          ),
          state
              ? const SizedBox()
              : Expanded(
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
