import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:znotes/components/NoteCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomGrid extends StatefulWidget {
  const CustomGrid({Key? key, required this.count}) : super(key: key);
  final int count;
  final String filter;
  @override
  State<CustomGrid> createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  late final List notes;

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return notes.isNotEmpty ? GridView.builder(
      itemCount: widget.count,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return buildNoteCard(notes[index]);
      },
    ): const Text("No notes to show!");
  }

  Widget buildNoteCard(not) {
    return NoteCard(
        categoryType: not.categoryType,
        isPinned: not.isPinned,
        isStarred: not.isStarred,
        contents: not.contents,
        dueDate: not.dueDate);
  }

  void fetchNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? noteListString = prefs.getString('notes');
    if (noteListString != null) {
      notes = json.decode(noteListString);
    }
  }
}
