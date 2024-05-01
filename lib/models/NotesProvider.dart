import 'package:flutter/material.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/utils/content_types.dart';

class NotesModel with ChangeNotifier{
  final List<Note> _notes = [
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category: Category(
          name: "Personal", color: categoryColors["Personal"] ?? Colors.indigo),
      color: Colors.blue,
      isStarred: true,
      isPinned: false,
      images: [],
      videos: [],
      audios: [],
      subtasks: [
        Subtask(title: 'Task 1', checked: false),
        Subtask(title: 'Task 2', checked: true),
        Subtask(title: 'Task 2', checked: true),
        Subtask(title: 'Task 2', checked: true),
        Subtask(title: 'Task 2', checked: true),
      ],
      completed: false,
      dueDate: DateTime(2024, 4, 4),
      reminders: [DateTime(2023, 10, 10), DateTime(2023, 10, 13)],
    ),
    // Existing Note
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category:
      Category(name: "work", color: categoryColors["work"] ?? Colors.indigo),
      color: Colors.blue,
      isStarred: true,
      isPinned: false,
      images: [],
      videos: [],
      audios: [],
      subtasks: [
        Subtask(title: 'Task 1', checked: false),
        Subtask(title: 'Task 2', checked: true),
        Subtask(title: 'Task 2', checked: true),
        Subtask(title: 'Task 2', checked: true),
        Subtask(title: 'Task 2', checked: true),
      ],
      completed: false,
      dueDate: DateTime(2023, 10, 15),
      reminders: [DateTime(2023, 10, 10), DateTime(2023, 10, 13)],
    ),
    Note(
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
      ],
      completed: false,
      dueDate: DateTime(2023, 10, 18),
      reminders: [DateTime(2023, 10, 15), DateTime(2023, 10, 17)],
    ),
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category:
      Category(name: "work", color: categoryColors["work"] ?? Colors.indigo),
      color: Colors.blue,
      isStarred: true,
      isPinned: false,
      images: [
        // ImageContent(path: 'assets/images/musk.jpg')
      ],
      videos: [],
      audios: [],
      subtasks: [
        Subtask(title: 'Task 1', checked: false),
        Subtask(title: 'Task 2', checked: true),
      ],
      completed: false,
      dueDate: DateTime(2023, 10, 15),
      reminders: [DateTime(2023, 10, 10), DateTime(2023, 10, 13)],
    ),
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category:
      Category(name: "Study", color: categoryColors["Study"] ?? Colors.amber),
      color: Colors.yellow,
      isStarred: true,
      isPinned: false,
      images: [],
      videos: [],
      audios: [AudioContent(path: 'audios/stromae.mp3')],
      subtasks: [
        Subtask(title: 'Read Chapter 5', checked: true),
        Subtask(title: 'Complete Assignment', checked: false),
      ],
      completed: false,
      dueDate: DateTime(2023, 10, 18),
      reminders: [DateTime(2023, 10, 15), DateTime(2023, 10, 17)],
    ),
    // 4 Additional Notes
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category: Category(
          name: "Personal",
          color: categoryColors["Personal"] ?? Colors.deepPurple),
      color: Colors.red,
      isStarred: false,
      isPinned: true,
      images: [],
      videos: [],
      audios: [],
      subtasks: [
        Subtask(title: 'Call friend', checked: false),
        Subtask(title: 'Book tickets', checked: true),
        Subtask(title: 'Task 2', checked: true),
      ],
      completed: true,
      dueDate: DateTime(2023, 10, 12),
      reminders: [DateTime(2023, 10, 8), DateTime(2023, 10, 10)],
    ),
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category:
      Category(name: "Study", color: categoryColors["Study"] ?? Colors.amber),
      color: const Color(0xff6066f5),
      isStarred: true,
      isPinned: false,
      images: [
        ImageContent(path: 'assets/images/musk.jpg'),
        ImageContent(path: 'assets/images/musk.jpg'),
        ImageContent(path: 'assets/images/musk.jpg')
      ],
      videos: [],
      audios: [],
      subtasks: [
        Subtask(title: 'Read Chapter 5', checked: true),
        Subtask(title: 'Complete Assignment', checked: false),
      ],
      completed: false,
      dueDate: DateTime(2023, 10, 18),
      reminders: [DateTime(2023, 10, 15), DateTime(2023, 10, 17)],
    ),
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category:
      Category(name: "Study", color: categoryColors["Study"] ?? Colors.amber),
      color: const Color(0xffe46565),
      isStarred: true,
      isPinned: false,
      images: [],
      videos: [],
      audios: [],
      subtasks: [
        Subtask(title: 'Read Chapter 5', checked: true),
        Subtask(title: 'Complete Assignment', checked: false),
      ],
      completed: false,
      dueDate: DateTime(2023, 10, 18),
      reminders: [DateTime(2023, 10, 15), DateTime(2023, 10, 17)],
    ),
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category: Category(
          name: "Shopping", color: categoryColors["Shopping"] ?? Colors.blueGrey),
      color: Colors.teal,
      isStarred: false,
      isPinned: true,
      images: [],
      videos: [],
      audios: [],
      subtasks: [
        Subtask(title: 'Buy gifts', checked: false),
        Subtask(title: 'Pickup package', checked: true),
      ],
      completed: false,
      dueDate: DateTime(2023, 10, 20),
      reminders: [DateTime(2023, 10, 18), DateTime(2023, 10, 19)],
    ),
    Note(
      titleDescription:
      "Task n with description that I want to cut and show less text",
      category: Category(
          name: "Others", color: categoryColors["Others"] ?? Colors.blueAccent),
      color: Colors.blueGrey,
      isStarred: false,
      isPinned: false,
      images: [],
      videos: [],
      audios: [],
      subtasks: [
        Subtask(title: 'Research topic', checked: false),
        Subtask(title: 'Send email', checked: true),
      ],
      completed: true,
      dueDate: DateTime(2023, 10, 25),
      reminders: [DateTime(2023, 10, 22), DateTime(2023, 10, 24)],
    ),
    Note(
      titleDescription: "Task n with description that I want to cut and show less text",
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
      ],
      completed: false,
      dueDate: DateTime(2023, 10, 18),
      reminders: [DateTime(2023, 10, 15), DateTime(2023, 10, 17)],
    ),
  ];

  SortType _currentSortFilter = SortType.byScheduledDate;
  SortType get currentSortFilter => _currentSortFilter;
  List<Note> get notes => _notes;
  void updateCurrentSortFilter(SortType sortFilter){
    _currentSortFilter = sortFilter;
    notifyListeners();
  }
  void addNote(Note n){
    _notes.add(n);
    notifyListeners();
  }

  void removeNote(Note n){
    _notes.remove(n);
    notifyListeners();
  }

  void sortNotes(SortType currentSortFilter) {
    notes.sort((a, b) {
      switch(currentSortFilter){
        case SortType.byDateChanged:
          if (a.modifiedDate.isAfter(b.modifiedDate)) {
            return -1;
          } else {
            return 1;
          }
        case SortType.byAlphabet:
          return a.titleDescription.compareTo(b.titleDescription);
        case SortType.byDateAdded:
          if (a.createdAt.isAfter(b.createdAt)) {
            return -1;
          } else {
            return 1;
          }
        case SortType.byScheduledDate:
          if (a.dueDate.isAfter(b.dueDate)) {
            return -1;
          } else {
            return 1;
          }
        default:
          print(notes);
          return 0;
      }
    });
    notifyListeners();
  }
}