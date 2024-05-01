import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, required this.text, required this.isSelected})
      : super(key: key);
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isSelected
            ? const Flexible(
                flex: 3,
                child:  Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 20.0,
                ),
              )
            : const SizedBox(),
        const Spacer(flex: 1),
        Expanded(flex:16,child: Text(text))
      ],
    );
  }
}
