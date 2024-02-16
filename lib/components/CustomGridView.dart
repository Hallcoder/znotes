import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  late List<Widget> firstColumn = [];
  late List<Widget> secondColumn = [];

  late int count = 0;

  @override
  void initState() {
    super.initState();
    print("Calling initState");
    fetchNotes();
    for (Note e in testNotes) {
      print("Calling initState ${testNotes.indexOf(e)}");
      if (testNotes.indexOf(e) % 2 == 0) {
        firstColumn.add(buildNoteCard(e));
        print(firstColumn[0]);
      } else {
        secondColumn.add(buildNoteCard(e));
      }
    }
  }

  // List<List<Note>> createLists(){
  //
  // }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double columnWidthPercentage = 0.5; // 80%
    double columnWidth = columnWidthPercentage * screenWidth;
    return testNotes.isNotEmpty
        ? SingleChildScrollView(
            child:
              Row(children: [
                SizedBox(
                  width: columnWidth,
                  child: Column(
                    children: firstColumn,
                  ),
                ),
                SizedBox(
                  width: columnWidth,
                  child: Column(
                    children: secondColumn,
                  ),
                )
              ]),
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
      print("Note Category ${note.category}");
      print("Filter ${widget.filter}");
      return note.category.toString().toLowerCase().trim() ==
          widget.filter.toLowerCase().trim();
    }).toList();
    print("Notes filtered $filteredNotes");
    return filteredNotes;
  }
}
