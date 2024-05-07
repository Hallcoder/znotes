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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (BuildContext context) => NoteCreationModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          actions: const [
            Icon(Icons.star_outline_rounded,color: Colors.grey,size:35.0),
            SizedBox(width: 10),
            Icon(Icons.share_outlined, color: Colors.grey,size:30.0),
            SizedBox(width: 10),
          ],
        ),
        body:   Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TitleEntry(),
                const AddMediaSection(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: screenSize.height * 0.4, // Adjust the height as needed
                  child: const SubtasksSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
