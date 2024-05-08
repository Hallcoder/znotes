import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:znotes/constants.dart';

import '../utils/content_types.dart';

class NoteCreationModel with ChangeNotifier {
  // final bool is
   Note _note = Note.withProperties(
    titleDescription:
        "Task n with description that I want to cut and show less text",
    category:
        Category(name: "Study", color: categoryColors["Study"] ?? Colors.amber),
    color: Colors.yellow,
    isStarred: true,
    isPinned: false,
    images: [],
    videos: [],
    audios: [],
    subtasks: [
      Subtask(title: 'Read Chapter 5', checked: true),
      Subtask(title: 'Complete Assignment', checked: false),
      Subtask(title: 'Learn dancing', checked: false),
      Subtask(title: 'Riez seulement', checked: false)
    ],
    completed: false,
    dueDate: DateTime(2023, 10, 18),
    reminders: [DateTime(2023, 10, 15), DateTime(2023, 10, 17)],
  );

  Note get note => _note;

  void reorder(int oldIndex, int newIndex) {
    final item = note.subtasks.removeAt(oldIndex);
    note.subtasks.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
    notifyListeners();
  }

  void updateNote(Note not) {
    print("Old note ${_note.subtasks[0].title}");
    _note = not;
    print("New note ${_note.subtasks[0].title}");
    notifyListeners();
  }

  void addSubTask(Subtask st){
    if(st.title.isNotEmpty){
      _note.subtasks.add(st);
    }
    notifyListeners();
  }
  void deleteSubTask(Subtask st){
    int index = _note.subtasks.indexOf(st);
    if(index >= 0){
      _note.subtasks.removeAt(index);
    }
    notifyListeners();
  }
  void updateSubTask(Subtask oldSt, Subtask newSt){
    int index = _note.subtasks.indexOf(oldSt);
    if(index >= 0){
      _note.subtasks[index] = newSt;
    }
    notifyListeners();
  }
}
