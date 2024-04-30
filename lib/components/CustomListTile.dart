import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, required this.text, required this.isSelected})
      : super(key: key);
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        isSelected
            ? const SizedBox(
                width: 20.0,
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 20.0,
                ))
            : const SizedBox(),
        const SizedBox(
          width: 40.0,
        ),
        Text(text, textAlign: TextAlign.start)
      ],
    );
  }
}
