import 'dart:ui';

import 'package:flutter/material.dart';

var primaryIconColor = Colors.blueGrey;

List tabs = [
  {
    "child":"All",
    "title":const Text("All")
  },
  {
    "child":"Categories",
    "title":const Text("#Categories")
  },
  {
    "child":"Completed",
    "title":const Text("Completed")
  },
  {
    "child":"Calendar",
    "title":const Text("Calendar")
  },
  {
    "child":"Unsorted",
    "title":const Text("Unsorted")
  }
];

List<Widget> renderedTabs = [];
List<Widget> tabViews = [];

