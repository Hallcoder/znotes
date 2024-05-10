import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:znotes/components/NoteCreationPage/SubtaskTile.dart';
import 'package:znotes/models/NoteCreationModel.dart';
import 'package:znotes/utils/content_types.dart';

class AddSubtaskTextField extends StatefulWidget {
  const AddSubtaskTextField({Key? key}) : super(key: key);

  @override
  State<AddSubtaskTextField> createState() => _AddSubtaskTextFieldState();
}

class _AddSubtaskTextFieldState extends State<AddSubtaskTextField> {
  bool isAddingTask = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final noteCreationProvider = Provider.of<NoteCreationModel>(context);
    Note note = noteCreationProvider.note;
    return !isAddingTask
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Subtask ${note.subtasks.length + 1}"
                  ),
                  onTap: (){
                    setState(() {
                      isAddingTask = true;
                    });
                    noteCreationProvider.addSubTask(Subtask(title:textEditingController.text,checked: false));
                  },
                  onTapOutside: (e) {
                    setState(() {
                      isAddingTask = false;
                    });
                  },
                  controller: textEditingController,
                ),
              ),
            ])
        : SubtaskTile(st: Subtask(title: "", checked: false),focus: true);
  }
}
