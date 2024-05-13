import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:znotes/models/NoteCreationModel.dart';
import 'package:znotes/utils/content_types.dart';

class AddSubtaskTextField extends StatefulWidget {
  const AddSubtaskTextField({Key? key}) : super(key: key);

  @override
  State<AddSubtaskTextField> createState() => _AddSubtaskTextFieldState();
}

class _AddSubtaskTextFieldState extends State<AddSubtaskTextField> {
  bool isAddingTask = false;
  Subtask st = Subtask(title: "", checked: false);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final noteCreationProvider = Provider.of<NoteCreationModel>(context);
    Note note = noteCreationProvider.note;
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        isAddingTask
            ? Icon(Icons.reorder_rounded, size: 16.0, color: Colors.grey[400])
            : const SizedBox(),
        isAddingTask
            ? Checkbox(
                value: st?.checked ?? false, onChanged: (bool? value) {})
            : const SizedBox(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: TextField(
            decoration: InputDecoration(
                hintText: "Subtask ${note.subtasks.length + 1}"),
            onTapOutside: (e) {
              setState(() {
                isAddingTask = false;
              });
            },
            controller: textEditingController,
          ),
        ),
      ]),
    );
  }

  void initiateAddingSubTask() {
    setState(() {
      st = Subtask(title: "", checked: false);
    });
  }
}

class AddSubTaskTile extends StatelessWidget {
  const AddSubTaskTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
