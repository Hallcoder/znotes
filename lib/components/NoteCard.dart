import 'package:flutter/material.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/utils/content_types.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Container(
        decoration: BoxDecoration(
          color: categoryColors[widget.note.category.name],
        ),
        child: Column(
          children: [
            Row(
              children: [
                widget.note.isStarred
                    ? const Icon(Icons.star_border_rounded)
                    : const SizedBox(),
                Text(widget.note.category.name)
              ],
            ),
            const Expanded(
              child: SizedBox(
                width: 400.0,
                height: 300.0,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
