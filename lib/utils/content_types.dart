import 'dart:ui';
import 'package:uuid/uuid.dart';

enum ContentType { audio, image, video, checkList }

class Content {
  final ContentType type;
  final String path;

  Content({required this.type, required this.path});
}

class Category {
  final String name;
  final Color color;

  Category({required this.name, required this.color});
}
var uuid = const Uuid();
class Note {
  String id;
  Category category;
  Color color;
  bool isStarred;
  bool isPinned;
  String titleDescription;
  List<ImageContent> images;
  List<VideoContent> videos;
  List<AudioContent> audios;
  List<Subtask> subtasks;
  bool completed;
  DateTime dueDate;
  List<DateTime> reminders;
  Note(
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
      required this.reminders}):id = uuid.v4();

  @override
  String toString() {
    return "This note is described as '$titleDescription'";
  }
}

class Subtask {
  final String title;
  final bool checked;

  Subtask({required this.title, required this.checked});
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

  enum ActionType{
    setComplete,
    copyNote,
    pinNote,
    markNoteAsFavorite,
    addNoteAsWidget,
    deleteNote
  }
