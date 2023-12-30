import 'package:flutter/material.dart';
import 'package:znotes/utils/content_types.dart';

class NoteCard extends StatefulWidget {
  const NoteCard(
      {Key? key,
      required this.categoryType,
      required this.isPinned,
      required this.isStarred,
      required this.contents, required this.dueDate})
      : super(key: key);
  final CategoryType categoryType;
  final bool isPinned;
  final bool isStarred;
  final List<Content> contents;
  final DateTime dueDate;


  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Center(
      child: Column(
        children: [
          Row(),
        ],
      ),
    ));
  }
}
