import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddSubtaskTextField extends StatefulWidget {
  const AddSubtaskTextField({Key? key}) : super(key: key);

  @override
  State<AddSubtaskTextField> createState() => _AddSubtaskTextFieldState();
}

class _AddSubtaskTextFieldState extends State<AddSubtaskTextField> {
  @override
  Widget build(BuildContext context) {
    bool isAddingTask = false;
    TextEditingController textEditingController = TextEditingController();
    return GestureDetector(
      onTap: (){
        setState(() {
          isAddingTask = true;
        });
      },
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: TextField(
            onTapOutside:(e){
              print("out of focus");
            },
            controller: textEditingController,
          ),
        ),
        const Icon(Icons.close_rounded)
      ]),
    );
  }
}
