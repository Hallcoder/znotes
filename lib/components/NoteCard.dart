import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/utils/content_types.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key, required this.note, required this.audioPlayer});

  final AudioPlayer audioPlayer;
  final Note note;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.note.category.name);
    return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      // width: 150.0,
      decoration: BoxDecoration(
          color: categoryColors[widget.note.category.name],
          borderRadius: const BorderRadius.all(Radius.circular(12.0))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    widget.note.isStarred
                        ? const Icon(Icons.star_border_rounded,size:16.0)
                        : const SizedBox(),
                    Text(widget.note.category.name),
                  ],
                ),
              ),
              widget.note.isPinned
                  ? const Icon(Icons.push_pin_outlined,size: 16.0,)
                  : const SizedBox(),
            ],
          ),
          buildContentHighestPriority(widget.note)
        ],
      ),
    ),
      );
  }

  Widget buildContentHighestPriority(Note note) {
    debugPrint("Note here $note");
    if (note.images.isNotEmpty) {
      return Image.asset(note.images[0].path);
    } else if (note.audios.isNotEmpty) {
      return GestureDetector(
          onTap: () {
            debugPrint("Playing Audio");
            widget.audioPlayer.play(note.audios[0].path as Source);
          },
          child: const Icon(Icons.audiotrack_rounded));
    } else if (note.videos.isNotEmpty) {
      final VideoPlayerController videoController =
          VideoPlayerController.asset(note.videos[0].path);
      return Stack(
        children: [
          AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: VideoPlayer(videoController),
          ),
          GestureDetector(
            onTap: () {
              if (videoController.value.isPlaying) {
                videoController.pause();
              } else {
                videoController.play();
              }
            },
            child: !videoController.value.isPlaying
                ? const Icon(Icons.play_circle_fill_rounded)
                : const Icon(Icons.pause),
          )
        ],
      );
    } else {
      if (note.subtasks.isNotEmpty) {
        return ListView.builder(
              shrinkWrap: true,
                itemCount: note.subtasks.length > 4 ? 4 : note.subtasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                      title: Text(note.subtasks[index].title),
                      value: note.subtasks[0].checked,
                      onChanged: null);
                });
      }
      return const SizedBox(width: 100.0, height: 100.0);
    }
  }
}
