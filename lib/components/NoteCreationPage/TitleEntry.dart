import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:znotes/models/NoteCreationModel.dart';
import 'package:znotes/utils/content_types.dart';

class TitleEntry extends StatelessWidget {
  const TitleEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesCreationProvider = Provider.of<NoteCreationModel>(context);
    Note note = notesCreationProvider.note;
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.12,
      width: screenSize.width,
      margin: const EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
          color: note.category != null ? note?.category?.color : Colors.grey[400],
          borderRadius: const BorderRadius.all(Radius.circular(12.0))),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: TextFormField(
          initialValue: note?.titleDescription ??
              "", // or widget.note != null ? widget.note.titleDescription: ""
        ),
      ),
    );
  }
}
