import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddMediaButton extends StatelessWidget {
  const AddMediaButton({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: Colors.grey[500], borderRadius: BorderRadius.circular(12.0)),
        child:  Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size:45
              ),
            ),
          ],
        ),
      ),
    );
  }
}
