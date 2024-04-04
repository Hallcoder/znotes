import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NoteEditScreen extends StatefulWidget {
  const NoteEditScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ),
        actions: const [
          Icon(Icons.star_rounded, color: Colors.grey),
          SizedBox(width: 10),
          Icon(Icons.share_outlined, color: Colors.grey),
          SizedBox(width: 10),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
             Container(
              height:  screenSize.height * 0.12,
              width: screenSize.width,
              decoration:const BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(12.0))
              ),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child:  Container(
                  child: TextFormField(),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
