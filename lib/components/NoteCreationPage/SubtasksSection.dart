import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:znotes/models/NoteCreationModel.dart';
import 'package:znotes/utils/content_types.dart';

import 'SubtaskTile.dart';

class SubtasksSection extends StatefulWidget {
  const SubtasksSection({Key? key}) : super(key: key);

  @override
  State<SubtasksSection> createState() => _SubtasksSectionState();
}

class _SubtasksSectionState extends State<SubtasksSection> {
  final bool isAddingTasks = false;
  List<Widget> subtasks = [];

  @override
  Widget build(BuildContext context) {
    final noteCreationProvider = Provider.of<NoteCreationModel>(context);
    final Note note = noteCreationProvider.note;
    Size size = MediaQuery.of(context).size;
    Uuid uuid = const Uuid();
    subtasks = [];
    for (final st in note.subtasks) {
      subtasks.add(SubtaskTile(
        key: ValueKey(uuid.v4()),
        st: st,
      ));
    }
    return Container(
      height: size.height * (subtasks.length * 0.15),
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      margin: const EdgeInsets.only(top:8.0),
      child: ReorderableListView(
        header: const Text("Subtasks"),
        children: subtasks,
        onReorder: (oldIndex, newIndex) {
          noteCreationProvider.reorder(oldIndex, newIndex);
        }
      ),
    );
  }
}
