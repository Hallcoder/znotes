import 'package:flutter/material.dart';
import 'package:znotes/components/NoteCreationPage/AddMediaButton.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/utils/content_types.dart';

class AddMediaSection extends StatelessWidget {
  const AddMediaSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> displayedMediaButtons = [];
    for (MediaButton button in mediaButtons){
      displayedMediaButtons.add(AddMediaButton(icon: button.icon));
    }
    //for now it will rows only later I will have to add the preview wrap too for media added so far
    return Row(
      children: displayedMediaButtons,
    );
  }
}
