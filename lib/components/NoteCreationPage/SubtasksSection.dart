import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:znotes/components/NoteCreationPage/add_subtask_text_field.dart';
import 'package:znotes/models/NoteCreationModel.dart';
import 'package:znotes/utils/content_types.dart';

import 'SubtaskTile.dart';

class SubtasksSection extends StatefulWidget {
  const SubtasksSection({Key? key, required this.outerScrollController})
      : super(key: key);
  final ScrollController outerScrollController;

  @override
  State<SubtasksSection> createState() => _SubtasksSectionState();
}

class _SubtasksSectionState extends State<SubtasksSection> {
  final bool isAddingTasks = false;
  List<Widget> subtasks = [];
  List<Subtask> completedSubtasks = [];

  @override
  Widget build(BuildContext context) {
    final noteCreationProvider = Provider.of<NoteCreationModel>(context);
    Size size = MediaQuery.of(context).size;
    Uuid uuid = const Uuid();
    subtasks = [];
    for (final st in noteCreationProvider.note.subtasks) {
      if (st.checked) {
        completedSubtasks.add(st);
        continue;
      }
      subtasks.add(SubtaskTile(
        key: ValueKey(uuid.v4()),
        st: st,
      ));
    }
    subtasks.add(AddSubtaskTextField(key: ValueKey(uuid.v4())));
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            height: (subtasks.length + 1) * 45.0,
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            margin: const EdgeInsets.only(top: 8.0),
            // decoration: BoxDecoration(border: Border.all(width: 2.0)),
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollEndNotification) {
                  if (widget.outerScrollController.position.extentAfter == 0) {
                    // Inner list is at the end, notify parent
                    Scrollable.of(context)?.position.moveTo(
                          Scrollable.of(context)!.position.pixels + 100,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease,
                        );
                  }
                }
                return false;
              },
              child: ReorderableListView(
                  scrollController: widget.outerScrollController,
                  header: const Text("Subtasks"),
                  children: subtasks,
                  onReorder: (oldIndex, newIndex) {
                    noteCreationProvider.reorder(oldIndex, newIndex);
                  }),
            ),
          ),
          SizedBox(
            height: size.height * (subtasks.length * 0.103),
            child: ListView.builder(
                itemCount: completedSubtasks.length,
                itemBuilder: (context, index) {
                  return SubtaskTile(st: completedSubtasks[index]);
                }),
          )
        ],
      ),
    );
  }
}
