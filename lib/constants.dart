import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
    "options": ["any", "today","tomorrow","Set date"],
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
List<MediaButton> mediaButtons = [
  MediaButton(icon: Icons.video_file),
  MediaButton(icon: Icons.image),
  MediaButton(icon: Icons.mic),
  MediaButton(icon: Icons.format_paint)
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


