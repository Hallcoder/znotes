import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:znotes/models/NoteCreationModel.dart';
import 'package:znotes/utils/content_types.dart';

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
    Uuid uuid = const Uuid();
    subtasks = [];
    for (final st in note.subtasks) {
      subtasks.add(ListTile(
        leading: const Icon(Icons.reorder_rounded, size: 14.0),
        key: ValueKey(uuid.v4()),
        title: Text(st.title),
      ));
    }
    return ReorderableListView(
        header: const Text("Subtasks"),
        children: subtasks,
        onReorder: (oldIndex, newIndex) {
          noteCreationProvider.reorder(oldIndex, newIndex);
        });
  }
}
