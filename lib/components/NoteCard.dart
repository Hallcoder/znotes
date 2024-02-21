import 'dart:io';

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
  TextStyle whiteText = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    print(widget.note.category.name);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        // width: 150.0,
        decoration: BoxDecoration(
          color: categoryColors[widget.note.category.name],
          borderRadius: widget.note.isPinned
              ? const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0))
              : const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.note.isStarred
                          ? const Icon(Icons.star_rounded,
                              size: 16.0, color: Color(0xfff8f38e))
                          : const SizedBox(),
                      widget.note.audios.isEmpty
                          ? const SizedBox()
                          : const Icon(Icons.play_circle),
                      widget.note.isPinned
                          ? const Icon(
                              Icons.push_pin_outlined,
                              size: 16.0,
                              color: Color(0xfff8f38e),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  Text(
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      "#${widget.note.category.name}")
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Text(
                  "${widget.note.titleDescription.substring(0, 10)}...",
                  style: whiteText
              ),
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
          widget.audioPlayer.play(AssetSource(widget.note.audios[0].path));
        },
        child: const Icon(Icons.audiotrack_rounded),
      );
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
            itemCount: note.subtasks.length > 4 ? 5 : note.subtasks.length,
            itemBuilder: (BuildContext context, int index) {
              return index != 4
                  ? CheckboxListTile(
                      title: Text(style: whiteText, note.subtasks[index].title),
                      value: note.subtasks[0].checked,
                      dense: true,
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: null)
                  : ListTile(
                      title: Text(
                        style: whiteText,
                        "Load more...",
                      ),
                    );
            });
      }
      return const SizedBox(width: 100.0, height: 100.0);
    }
  }
}
