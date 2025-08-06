import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';

class EditNote extends StatefulWidget {
  final Note note;
  const EditNote({super.key, required this.note});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title ?? '';
    noteController.text = widget.note.content ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void updateNote() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title cannot be empty")),
      );
      return;
    }

    // Aggiorniamo solo titolo e contenuto
    widget.note.title = titleController.text.trim();
    widget.note.content = noteController.text.trim();

    Provider.of<NotesProvider>(context, listen: false)
        .updateNote(widget.note);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Note updated successfully")),
    );

    Navigator.of(context).pop();
  }

  void deleteNote() {
    Provider.of<NotesProvider>(context, listen: false)
        .deleteNote(widget.note);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Note deleted successfully")),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: deleteNote,
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
          IconButton(
            onPressed: updateNote,
            icon: const Icon(Icons.check_circle, color: Colors.green, size: 30),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: noteController,
                  maxLines: null,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
