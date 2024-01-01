import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:znotes/components/NoteCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:znotes/utils/content_types.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({Key? key, required this.filter}) : super(key: key);
  final String filter;

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  late List<Note> notes = [];
  late int count = 0;

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return notes.isNotEmpty
        ? GridView.builder(
            itemCount: count,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext context, int index) {
              return buildNoteCard(notes[index]);
            },
          )
        : const Text("No notes to show!");
  }

  Widget buildNoteCard(not) {
    return NoteCard(
      note: not,
    );
  }

  void fetchNotes() async {
    // TODO : implement fetching based on the selected tab
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? noteListString = prefs.getString('notes');
    if (noteListString != null) {
      notes = filterNotes(noteListString) as List<Note>;

      count = notes.length;
    }
  }

  List<dynamic> filterNotes(String? noteListString) {
    List unfilteredNotes = json.decode(noteListString!);
    List filteredNotes = unfilteredNotes.where((note) {
      debugPrint("Note Category ${note.category}");
      debugPrint("Filter ${widget.filter}");
      return note.category.toString().toLowerCase().trim() ==
          widget.filter.toLowerCase().trim();
    }).toList();
    debugPrint("Notes filtered $filteredNotes");
    return filteredNotes;
  }
}
