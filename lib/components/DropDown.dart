import 'package:flutter/material.dart';
import 'package:znotes/utils/content_types.dart';

class DropDown extends StatelessWidget {
  const DropDown({Key? key, required this.item, required this.n})
      : super(key: key);
  final MenuItem item;
  final Note n;

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      child: GestureDetector(
        onTap: item.doAction!(n),
        child: Text(item.title),
      ),
    );
  }
}
