import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:znotes/components/NoteCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/utils/content_types.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView(
      {Key? key,
      required this.filter,
      required this.audioPlayer,
      required this.options})
      : super(key: key);
  final String filter;
  final List<dynamic> options;
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
    fetchNotes();
    for (Note e in testNotes) {
      if (e.category.name.toLowerCase() == widget.filter.toLowerCase()) {
        if (testNotes.indexOf(e) % 2 == 0) {
          firstColumn.add(buildNoteCard(e));
        } else {
          secondColumn.add(buildNoteCard(e));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double columnWidthPercentage = 0.5; // 50%
    double columnWidth = columnWidthPercentage * screenWidth;
    List<Widget> optionsDisplayed = [];
    for (var i = 0; i < widget.options!.length; i++) {
      optionsDisplayed.add(
        Container(
          padding: const EdgeInsets.all(4.0),
          margin: const EdgeInsets.all(2.0),
          width: screenWidth * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 1.0,
              color: Colors.grey
            )
          ),
          child: Center(
            child: Text(
              widget.options![i],
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }
    return testNotes.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                Row(children: optionsDisplayed),
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
              ],
            ),
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
