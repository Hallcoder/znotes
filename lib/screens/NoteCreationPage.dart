import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:znotes/components/AddMediaButton.dart';
import 'package:znotes/constants.dart';

import '../utils/content_types.dart';

@RoutePage()
class NoteCreationPage extends StatefulWidget {
  const NoteCreationPage({Key? key, this.note}) : super(key: key);
  final Note? note;

  @override
  State<NoteCreationPage> createState() => _NoteCreationPageState();
}

class _NoteCreationPageState extends State<NoteCreationPage> {
  List<Widget> displayedMediaButtons = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    displayedMediaButtons = [];
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    for (MediaButton button in mediaButtons){
      displayedMediaButtons.add(AddMediaButton(icon: button.icon));
    }
      return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
            color: Colors.grey[400],
          ),
          actions: const [
            Icon(Icons.star_rounded, color: Colors.grey),
            SizedBox(width: 10),
            Icon(Icons.share_outlined, color: Colors.grey),
            SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenSize.height * 0.12,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                        color: widget.note != null
                            ? widget.note?.category?.color
                            : Colors.grey,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(12.0))),
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: TextFormField(
                        initialValue: widget.note?.titleDescription ??
                            "", // or widget.note != null ? widget.note.titleDescription: ""
                      ),
                    ),
                  ),
                  Wrap(),
                  Row(
                    children: displayedMediaButtons,
                  )
                ],
              )),
        ),
      );
  }
}
