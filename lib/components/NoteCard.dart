import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/routers/router.gr.dart';
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
  DateFormat formatter = DateFormat.yMMMMd('en_US');
  bool isAudioPlaying = false;
 @override
 void dispose() {
    super.dispose();
    widget.audioPlayer.stop();
  }
  @override
  void initState() {
    super.initState();
    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        setState(() {
          isAudioPlaying = true;
        });
      } else if (state == PlayerState.stopped) {
        isAudioPlaying = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          context.router.push(const NoteEditRoute());
        },
        onLongPress: () {
          showDropDownMenu(context: context);
        },
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
                            : const Icon(Icons.play_arrow_outlined),
                        widget.note.isPinned
                            ? const Icon(
                                Icons.push_pin_outlined,
                                size: 16.0,
                                color: Color(0xfff8f38e),
                              )
                            : const SizedBox(),
                        widget.note.subtasks.isEmpty
                            ? const SizedBox()
                            : const Icon(
                                Icons.view_list_outlined,
                                color: Colors.white,
                              )
                      ],
                    ),
                    Text(
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
                        "#${widget.note.category.name.toLowerCase()}")
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Text(
                    "${widget.note.titleDescription.substring(0, 10)}...",
                    style: whiteText),
              ),
              buildContentHighestPriority(widget.note),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  formatter.format(widget.note.dueDate),
                  style: whiteText,
                ),
              )
            ],
          ),
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
        onTap: () async {
          if(isAudioPlaying){
            await widget.audioPlayer.stop();
            setState(() {
              isAudioPlaying = false;
            });
          }else{
            await widget.audioPlayer.play(AssetSource(widget.note.audios[0].path));
            setState(() {
              isAudioPlaying = true;
            });
          }
        },
        child: Center(
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(), shape: BoxShape.circle),
            child: !isAudioPlaying
                ? const Icon(
                    Icons.play_arrow_outlined,
                    size: 32.0,
                  )
                : const Icon(
                    Icons.stop_circle_outlined,
                    size: 32.0,
                  ),
          ),
        ),
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

  void showDropDownMenu({required BuildContext context}) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset bottomRightPosition = button
        .localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay);

    final RelativeRect position = RelativeRect.fromLTRB(
      bottomRightPosition.dx - 50, // Adjust this value based on the menu width
      bottomRightPosition.dy - 200,
      // Adjust this value based on the menu height
      bottomRightPosition.dx,
      bottomRightPosition.dy,
    );
    showMenu(context: context, position: position, items: const [
      PopupMenuItem(child: Text("Completed")),
      PopupMenuItem(child: Text("Mark as Favorite")),
      PopupMenuItem(child: Text("Add as widget")),
      PopupMenuItem(child: Text("Copy note")),
      PopupMenuItem(child: Text("Pin note"))
    ]);
  }
}
