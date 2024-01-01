import 'dart:ui';

enum ContentType{audio,image,video,checkList}


class Content{
  final ContentType type;
  final String path;

  Content({required this.type, required this.path});
}

class Category{
  final String name;
  final Color color;

  Category({required this.name,required this.color});
}
class Note{
  final Category category;
  final Color color;
  final bool isStarred;
  final bool isPinned;
  final List<ImageContent> images;
  final List<VideoContent> videos;
  final List<AudioContent> audios;
  final List<String> subtasks;
  final bool completed;
  final DateTime dueDate;
  final List<DateTime> reminders;

  Note(this.isStarred, this.isPinned, {required this.category, required this.color, required this.images, required this.videos, required this.audios, required this.subtasks, required this.completed, required this.dueDate, required this.reminders});

}


class AudioContent extends Content{
  AudioContent({required String path}): super(type: ContentType.audio,path: path);
}

class VideoContent extends Content{
  VideoContent({required String path}): super(type: ContentType.video, path: path);
}

class ImageContent extends Content{
  ImageContent({required String path}): super(type: ContentType.image, path: path);
}

