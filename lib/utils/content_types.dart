import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

enum ContentType { audio, image, video, checkList }

class Content {
  final ContentType type;
  final String path;

  Content({required this.type, required this.path});
}

class Category {
  final String id;
  final String name;
  final Color color;

  Category({required this.name, required this.color}): id = uuid.v4();
}

var uuid = const Uuid();

class Note {
  Note() : id = uuid.v4();

  Note.withProperties(
      {required this.titleDescription,
      required this.isStarred,
      required this.isPinned,
      required this.category,
      required this.color,
      required this.images,
      required this.videos,
      required this.audios,
      required this.subtasks,
      required this.completed,
      required this.dueDate,
      required this.reminders})
      : id = uuid.v4();
  final String id;
  Category? category;
  Color? color;
  bool? isStarred = false;
  bool? isPinned = false;
  String? titleDescription = "";
  List<ImageContent> images = [];
  List<VideoContent> videos = [];
  List<AudioContent> audios = [];
  List<Subtask> subtasks = [];
  bool? completed = false;
  DateTime? dueDate;
  List<DateTime>? reminders;
  late DateTime modifiedDate = DateTime.now();
  late DateTime createdAt = DateTime.now();

  @override
  String toString() {
    return "This note's id is ['$id']";
  }
}

class Subtask {
  String id;
  String title;
  bool checked;

  Subtask({required this.title, required this.checked}):id = uuid.v4();
}

class MediaButton{
  late IconData icon;
  MediaButton({required this.icon});
}

class AudioContent extends Content {
  AudioContent({required String path})
      : super(type: ContentType.audio, path: path);
}

class VideoContent extends Content {
  VideoContent({required String path})
      : super(type: ContentType.video, path: path);
}

class ImageContent extends Content {
  ImageContent({required String path})
      : super(type: ContentType.image, path: path);
}

class MenuItem {
  final String title;
  final String successMessage;
  final ActionType doAction;

  MenuItem(this.title, this.doAction, this.successMessage);
}

enum ActionType {
  setComplete,
  copyNote,
  pinNote,
  markNoteAsFavorite,
  addNoteAsWidget,
  deleteNote
}

enum SortType { byDateChanged, byDateAdded, byAlphabet, byScheduledDate }
