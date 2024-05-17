import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:znotes/components/NoteCreationPage/AddMediaSection.dart';
import 'package:znotes/components/NoteCreationPage/SubtasksSection.dart';
import 'package:znotes/components/NoteCreationPage/TitleEntry.dart';
import 'package:znotes/models/NoteCreationModel.dart';

@RoutePage()
class NoteCreationPage extends StatefulWidget {
  const NoteCreationPage({Key? key}) : super(key: key);

  @override
  State<NoteCreationPage> createState() => _NoteCreationPageState();
}

class _NoteCreationPageState extends State<NoteCreationPage> {
  final ScrollController _outerScrollController = ScrollController();
  final ScrollController _innerScrollController = ScrollController();

  @override
  void dispose() {
    _outerScrollController.dispose();
    _innerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NoteCreationModel>(
      create: (BuildContext context) => NoteCreationModel(),
      child: Scaffold(
        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: NestedScrollView(
            controller: _outerScrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                 const SliverAppBar(
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Collapsing Toolbar"),
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star_outline_rounded, color: Colors.grey, size: 35.0),
                        SizedBox(width: 10),
                        Icon(Icons.share_outlined, color: Colors.grey, size: 30.0),
                        SizedBox(width: 10)
                      ],
                    )
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanUpdate: (details) {
                    // Manually trigger scroll when dragging
                    Scrollable.of(context)?.position.moveTo(
                      Scrollable.of(context)!.position.pixels - details.delta.dy,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.ease,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleEntry(),
                      const AddMediaSection(),
                      SubtasksSection(outerScrollController: _outerScrollController,),
                    ],
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
