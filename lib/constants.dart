import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:znotes/components/CustomGridView.dart';
import 'package:znotes/utils/content_types.dart';

var primaryIconColor = Colors.blueGrey;
Map<String, Color> categoryColors = {
  "work": const Color(0xFFE0E0E0), // Light gray
  "Personal": const Color(0xFFFFE0B2), // Light orange
  "Study": const Color(0xFFFFF9C4), // Soft yellow
  "Shopping": const Color(0xFFE1BEE7), // Light purple
  "others": const Color(0xFFC8E7D9), // Light green
};
List tabs = [
  {"child": "All", "title": const Text("All")},
  {"child": "Categories", "title": const Text("#Categories")},
  {"child": "Completed", "title": const Text("Completed")},
  {"child": "Calendar", "title": const Text("Calendar")},
  {"child": "Unsorted", "title": const Text("Unsorted")}
];

List<Widget> renderedTabs = [];
List<CustomGridView> tabViews = [];
List<Note> testNotes = [
  // Existing Note
   Note(
    category: Category(name: "work", color: Colors.blueGrey),
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
  // 4 Additional Notes
  Note(
    category: Category(name: "Personal", color: Colors.purple),
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
    category: Category(name: "Study", color: Colors.orange),
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
    category: Category(name: "Shopping", color: Colors.green),
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
    category: Category(name: "Others", color: Colors.grey),
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
];