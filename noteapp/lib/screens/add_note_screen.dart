// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/bloc/note_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
    this.add = true,
    this.description,
    this.title,
    this.id,
  });
  final bool add;
  final String? title;
  final String? description;
  final int? id;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    if (widget.title != null && widget.description != null) {
      titleController.text = widget.title!;
      contentController.text = widget.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(listener: (context, state) {
      if (state is ErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade300,
            duration: const Duration(seconds: 1),
            content: Text(state.errorMessage),
          ),
        );
      }
      if (state is ScuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green.shade300,
            duration: const Duration(seconds: 1),
            content: state.add
                ? const Text("Note Added")
                : const Text("Note Edited"),
          ),
        );
        state.add
            ? Navigator.pop(context)
            : Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }, builder: (context, state) {
      if (state is LoadingState) {
        return const Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.add ? "Add Note" : "Edit Note"),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  widget.add
                      ? context.read<NoteBloc>().add(
                            NoteAddEvent(
                              title: titleController.text,
                              content: contentController.text,
                            ),
                          )
                      : context.read<NoteBloc>().add(
                            NoteEditEvent(
                              title: titleController.text,
                              content: contentController.text,
                              id: widget.id!,
                            ),
                          );
                },
                child: const Text("Save"),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 100,
                    minLines: 1,
                    controller: contentController,
                    decoration: const InputDecoration(
                      labelText: "Note",
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
