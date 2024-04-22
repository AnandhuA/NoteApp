// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:noteapp/api/api.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.add ? "Add Note" : "Edit Note"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  contentController.text.isNotEmpty) {
                Map<String, dynamic> data = {
                  "id": widget.add
                      ? DateTime.now().microsecondsSinceEpoch
                      : widget.id,
                  "title": titleController.text,
                  "content": contentController.text
                };
                widget.add ? await addNote(data) : await updateNote(data);

                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("Please fill all the fields"),
                ));
              }
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
}
