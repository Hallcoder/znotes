import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:znotes/components/CustomGridView.dart';
import 'package:znotes/components/CustomListTile.dart';
import 'package:znotes/utils/content_types.dart';

var primaryIconColor = Colors.blueGrey;
Map<String, Color> categoryColors = {
  "work": const Color(0xffe46565), // Light gray
  "Personal": const Color(0xff6066f5), // Light orange
  "Study": const Color(0xffffb535), // Soft yellow
  "Shopping": const Color(0xff34c1fc), // Light purple
  "others": const Color(0xff139c6b), // Light green
};
final AudioPlayer audioPlayer = AudioPlayer();
List tabs = [
  {
    "child": "All",
    "title": const Text("All"),
    "options": [],
    "filterProperty": "all"
  },
  {
    "child": "Categories",
    "title": const Text("#Categories"),
    "options": ["work", "study", "personal"],
    "filterProperty": "category"
  },
  {
    "child": "Completed",
    "title": const Text("Completed"),
    "options": [],
    "filterProperty": "completion"
  },
  {
    "child": "Calendar",
    "title": const Text("Calendar"),
    "options": ["any", "today", "yesterday", "tomorrow"],
    "filterProperty": "date"
  },
  {
    "child": "Unsorted",
    "title": const Text("Unsorted"),
    "options": [],
    "filterProperty": "unsorted"
  },
  {
    "child": "Favorites",
    "title": const Text("Favorites"),
    "options": [],
    "filterProperty": "favorites"
  }
];

List<Widget> renderedTabs = [];
List<CustomGridView> tabViews = [];
List<Note> testNotes = [
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

final List<MenuItem> menuOptions = [
  MenuItem("Set Completed", ActionType.setComplete, "Success!"),
  MenuItem("Mark as Favorite", ActionType.markNoteAsFavorite, "Success!"),
  MenuItem("Add as a widget", ActionType.addNoteAsWidget, "Success!"),
  MenuItem("Copy Note", ActionType.copyNote, "Success!"),
  MenuItem("Pin Note", ActionType.pinNote, "Success!"),
  MenuItem("Delete Note", ActionType.deleteNote, "Success!")
];

const List<Widget> sortOptions = [
  PopupMenuItem(
    child: CustomListTile(text: "by date changed", isSelected: true),),
  PopupMenuItem(
    child: CustomListTile(text: "by date added", isSelected: false),
  ),
  PopupMenuItem(
    child: CustomListTile(text: "alphabetical", isSelected: false),),
  PopupMenuItem(
    child: CustomListTile(text: "by scheduled date", isSelected: false),),
];


