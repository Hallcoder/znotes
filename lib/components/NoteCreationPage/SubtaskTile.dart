import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:znotes/components/NoteCreationPage/add_subtask_text_field.dart';
import 'package:znotes/models/NoteCreationModel.dart';
import 'package:znotes/utils/content_types.dart';

class SubtaskTile extends StatefulWidget {
  const SubtaskTile({Key? key, required this.st}) : super(key: key);
  final Subtask st;

  @override
  State<SubtaskTile> createState() => _SubtaskTileState();
}

class _SubtaskTileState extends State<SubtaskTile> {
  bool isEditingSubTask = false;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final noteCreationProvider = Provider.of<NoteCreationModel>(context);
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 50.0,
      child: GestureDetector(
        onTap: () {
          if (!widget.st.checked) {
            setState(() {
              isEditingSubTask = true;
            });
            focusNode.requestFocus();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.st.checked
                ? const SizedBox(width: 12.0)
                : Icon(Icons.reorder_rounded,
                    size: 16.0, color: Colors.grey[400]),
            Checkbox(
                value: widget.st.checked, onChanged: (bool? value) {
                  Subtask newSt = widget.st;
                  newSt.checked = !widget.st.checked;
                  noteCreationProvider.updateSubTask(widget.st,newSt);
            },activeColor: widget.st.checked ?  Colors.grey:Colors.blueAccent),
            Expanded(
                child: isEditingSubTask
                    ? TextFormField(
                        focusNode: focusNode,
                        style: TextStyle(
                            decoration: widget.st.checked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: widget.st.checked
                                ? Colors.grey[300]
                                : Colors.black),
                        initialValue: widget.st.title,
                        decoration:
                            const InputDecoration(hintText: "Add subtask"),
                        onTapOutside: (e) {
                          setState(() {
                            isEditingSubTask = false;
                          });
                        },
                      )
                    : Text(
                        widget.st!.title,
                        style: TextStyle(
                            decoration: widget.st.checked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: widget.st.checked
                                ? Colors.grey[300]
                                : Colors.black),
                      )),
            isEditingSubTask || widget.st.checked
                ? GestureDetector(
                    onTap: () {
                      noteCreationProvider.deleteSubTask(widget.st);
                    },
                    child:
                        Icon(Icons.close, color: Colors.grey[600], size: 18.0))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
