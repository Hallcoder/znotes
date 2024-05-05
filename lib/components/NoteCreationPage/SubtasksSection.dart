import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:znotes/models/NoteCreationModel.dart';
import 'package:znotes/utils/content_types.dart';

class SubtasksSection extends StatefulWidget {
  const SubtasksSection({Key? key}) : super(key: key);

  @override
  State<SubtasksSection> createState() => _SubtasksSectionState();
}

class _SubtasksSectionState extends State<SubtasksSection> {
  final bool isAddingTasks = false;

  @override
  Widget build(BuildContext context) {
    final noteCreationProvider = Provider.of<NoteCreationModel>(context);
    final Note note = noteCreationProvider.note;
    return Flexible(
        child: Column(
      children: [
        const Text("Subtasks"),
        (isAddingTasks || note.subtasks.isNotEmpty)
            ? ReorderableListView.builder(
                itemCount: note.subtasks.length,
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    _update
                  });
                },
                itemBuilder: (context, index) {
                  Subtask item = note.subtasks[index];
                  return ListTile(
                    key: Key(item.title),
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_handle), // Draggable handle
                    ),
                    title:CheckboxListTile(
                      value: item.isChecked,
                      onChanged: (value) {
                        setState(() {
                          item.isChecked = value!;
                        });
                      },
                      title: TextFormField(
                        initialValue: item.title,
                        onChanged: (value) {
                          setState(() {
                            item.title = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter item title',
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Text("No Subtasks")
      ],
    ));
  }
}
