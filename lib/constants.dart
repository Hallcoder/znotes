import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:znotes/components/CustomGridView.dart';
import 'package:znotes/utils/content_types.dart';

var primaryIconColor = Colors.blueGrey;
Map<String, Color> categoryColors = {
  "work": const Color(0xFFE0E0E0), // Light gray
  "fun": const Color(0xFFFFE0B2), // Light orange
  "vacation": const Color(0xFFFFF9C4), // Soft yellow
  "church": const Color(0xFFE1BEE7), // Light purple
  "school": const Color(0xFFC8E6C9), // Light green
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
