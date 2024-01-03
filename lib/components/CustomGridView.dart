import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:znotes/components/NoteCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/utils/content_types.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView(
      {Key? key, required this.filter, required this.audioPlayer})
      : super(key: key);
  final String filter;
  final AudioPlayer audioPlayer;

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
    return testNotes.isNotEmpty
        ? Wrap(
      children: testNotes.map((note) => buildNoteCard(note)).toList()
      ,
    )
        : const Text("No notes to show!");
  }

  NoteCard buildNoteCard(not) {
    return NoteCard(
      note: not,
      audioPlayer: widget.audioPlayer,
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
