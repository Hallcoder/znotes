import 'package:flutter/material.dart';
import 'package:znotes/components/NoteCreationPage/AddSubtaskTextField.dart';
import 'package:znotes/utils/content_types.dart';

class SubtaskTile extends StatefulWidget {
  const SubtaskTile({Key? key, this.st, this.focus}) : super(key: key);
  final Subtask? st;
  final bool? focus;

  @override
  State<SubtaskTile> createState() => _SubtaskTileState();
}

class _SubtaskTileState extends State<SubtaskTile> {
  bool isEditingSubTask = false;
  late FocusNode focusNode = FocusNode();

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.focus != null && widget.focus == true) {
      focusNode.requestFocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isEditingSubTask = true;
        });
        focusNode.requestFocus();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.reorder_rounded, size: 16.0, color: Colors.grey[400]),
          Checkbox(
              value: widget.st?.checked ?? false, onChanged: (bool? value) {}),
          Expanded(
              child: isEditingSubTask ? TextFormField(
            initialValue: widget.st?.title,
            focusNode: focusNode,
            decoration: const InputDecoration(hintText: "Add subtask"),
            onTapOutside: (e) {
              setState(() {
                isEditingSubTask = false;
              });
              focusNode.unfocus();
            },
          ): Text(widget.st!.title)),
          isEditingSubTask ? Icon(Icons.close, color: Colors.grey[600], size: 18.0): const SizedBox()
        ],
      ),
    );
  }
}
