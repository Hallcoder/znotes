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
  Subtask st = Subtask(title: "", checked: false);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final noteCreationProvider = Provider.of<NoteCreationModel>(context);
    Note note = noteCreationProvider.note;
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          child: TextField(
            decoration: InputDecoration(
                hintText: "Subtask ${note.subtasks.length + 1}"),
            controller: textEditingController,
          ),
        ),
        GestureDetector(
          onTap: (){
            noteCreationProvider.addSubTask(Subtask(title: textEditingController.text,checked: false));
          },
          child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, border: Border.all(width: 1.0)),
              child: const Icon(Icons.check, color: Colors.lightGreen)),
        ),
        const SizedBox(width: 5.0),
        GestureDetector(
          child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, border: Border.all(width: 1.0)),
              child: const Icon(Icons.close, color: Colors.red)),
        )
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
