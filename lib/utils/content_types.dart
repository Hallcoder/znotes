enum ContentType{audio,image,video}
enum CategoryType{school,work,vacation,church,fun}

class Content{
  final ContentType type;
  final String path;

  Content({required this.type, required this.path});
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