// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:noteapp/api/api.dart';
import 'package:noteapp/bloc/bloc_bloc.dart';
import 'package:noteapp/colors/colors.dart';

import 'package:noteapp/screens/view_note_screen.dart';
import 'package:noteapp/screens/widgets/delete_pop_up_widget.dart';

class NoteWidget extends StatelessWidget {
  final List notesList;

  const NoteWidget({super.key, required this.notesList});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocBloc, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (BlocLoadingState):
              return const Center(
                child: CircularProgressIndicator(),
              );

            case const (BlocSuccessState):
              return GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: notesList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 4,
                ),
                itemBuilder: (context, index) {
                  print("-----------------------------------");
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
                    ),
                  );
                },
              );
            case const (BlocErrorState):
              return const Center(
                child: Text("error"),
              );

            default:
              return const SizedBox();
          }
        });
  }

  Widget note({
    required int index,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors[notes[index]["id"] % colors.length],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notesList[index]["title"] ?? "null",
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Text(
              notesList[index]["content"] ?? "null",
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
