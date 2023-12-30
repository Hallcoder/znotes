import 'package:flutter/material.dart';

class CustomGrid extends StatefulWidget {
  const CustomGrid({Key? key, required this.count}) : super(key: key);
  final int count;

  @override
  State<CustomGrid> createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.count,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {

      },
    );
  }
}
