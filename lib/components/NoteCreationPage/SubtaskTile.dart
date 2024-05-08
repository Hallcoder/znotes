import 'package:flutter/material.dart';
import 'package:znotes/utils/content_types.dart';

class SubtaskTile extends StatefulWidget {
  const SubtaskTile({Key? key, required this.st}) : super(key: key);
  final Subtask st;

  @override
  State<SubtaskTile> createState() => _SubtaskTileState();
}

class _SubtaskTileState extends State<SubtaskTile> {
  bool isEditingSubTask = false;
  late FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.reorder_rounded, size: 16.0, color: Colors.grey[400]),
        Checkbox(value: widget.st.checked, onChanged: (bool? value) {}),
        Expanded(
            child: isEditingSubTask
                ? TextFormField(
                    initialValue: widget.st.title,
                    focusNode: focusNode,
                    onTapOutside: (e) {
                      setState(() {
                        isEditingSubTask = false;
                      });
                        focusNode.unfocus();
                    },
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        isEditingSubTask = true;
                      });
                        focusNode.requestFocus();
                    },
                    child: Text(widget.st.title))),
        isEditingSubTask ? Icon(Icons.close, color: Colors.grey[600], size: 18.0):const SizedBox()
      ],
    );
  }
}
