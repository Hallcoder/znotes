import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:znotes/components/NoteCard.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/utils/content_types.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({Key? key,
    required this.filter,
    required this.audioPlayer,
    required this.options,
    required this.tab})
      : super(key: key);
  final String filter;
  final Map tab;
  final List<dynamic> options;
  final AudioPlayer audioPlayer;

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  List<Note> notes = [];
  List<Widget> firstColumn = [];
  List<Widget> secondColumn = [];
  int count = 0;
  String selectedOption = "";

  @override
  void initState() {
    super.initState();
    print("Widget filter: ${widget.tab["filterProperty"]}");
    selectedOption = widget.tab["options"].length > 0 ? widget.tab["options"][0]:"all";
    print("SelectedOption: $selectedOption");
    fetchNotes();
  }
  void fetchNotes(){
    firstColumn = [];
    secondColumn = [];
    var newNotes = filterTestNotes();
    for (Note e in newNotes) {
      if (newNotes.indexOf(e) % 2 == 0) {
        firstColumn.add(buildNoteCard(e));
      } else {
        secondColumn.add(buildNoteCard(e));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double columnWidthPercentage = 0.5; // 50%
    double columnWidth = columnWidthPercentage * screenWidth;
    List<Widget> optionsDisplayed = [];
    for (var i = 0; i < widget.options.length; i++) {
      optionsDisplayed.add(
        InkWell(
          onTap: (){
            setState(() {
              selectedOption = widget.options[i];
              fetchNotes();
            });
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            margin: const EdgeInsets.all(2.0),
            width: screenWidth * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: widget.options[i] == selectedOption ? Colors.black:null,
                border: Border.all(width: 1.0, color: Colors.grey)),
            child: Center(
              child: Text(
                widget.options[i],
                style:TextStyle(color: widget.options[i] == selectedOption ? Colors.white:Colors.grey),
              ),
            ),
          ),
        ),
      );
    }
    return  SingleChildScrollView(
      child: Column(
        children: [
          Wrap(children: optionsDisplayed),
          firstColumn.isNotEmpty || secondColumn.isNotEmpty ? Row(children: [
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
          ]) :const Center(child:Text("No notes to show!")),
        ],
      ),
    );
  }

  NoteCard buildNoteCard(not) {
    return NoteCard(
      note: not,
      audioPlayer: widget.audioPlayer,
    );
  }
   //TODO: implement fetchNotes with real Notes in sharedPreferences or an sqlite3 db
  // void fetchNotes() async {
  //   // TODO : implement fetching based on the selected tab
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? noteListString = prefs.getString('notes');
  //   if (noteListString != null) {
  //     notes = filterNotes(noteListString) as List<Note>;
  //     count = notes.length;
  //   }
  // }

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

  List<Note> filterTestNotes() {
    List<Note> notes = [];
    for (Note n in testNotes) {
      print(widget.tab);
      switch (widget.tab["filterProperty"]) {
        case "category":
          n.category.name.toLowerCase() == selectedOption.toLowerCase() ? notes.add(n) : null;
          break;
        case "date":
          if(selectedOption == "any") {
            notes.add(n);
            break;
          }
          else if (selectedOption == "today" &&
              (n.dueDate.day == DateTime
                  .now()
                  .day &&
                  n.dueDate.month == DateTime
                      .now()
                      .month &&
                  n.dueDate.year == DateTime
                      .now()
                      .year)) {
            notes.add(n);
          }
          else if (selectedOption == "tomorrow" && (n.dueDate.day == DateTime
              .now()
              .day + 1 &&
              n.dueDate.month == DateTime
                  .now()
                  .month &&
              n.dueDate.year == DateTime
                  .now()
                  .year)) {
            notes.add(n);
          } else if (selectedOption == "yesterday" && (n.dueDate.day == DateTime
              .now()
              .day - 1 &&
              n.dueDate.month == DateTime
                  .now()
                  .month &&
              n.dueDate.year == DateTime
                  .now()
                  .year)) {
            notes.add(n);
          }
          break;
        case "completion":
          if (n.completed) notes.add(n);
          break;
        default:
          notes = testNotes;
          break;
      }
    }
  return notes ;
  }

}
