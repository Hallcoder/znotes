import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:znotes/components/CustomGridView.dart';
import 'package:znotes/constants.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        shape: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black, // Specify the color of the underline
            width: 0.6, // Specify the width of the underline
          ),
        ),
      ),
      body: CustomGridView(
          filter: "Favorites",
          options: const [],
          audioPlayer: audioPlayer,
          tab:tabs[5]
      ),
    );
  }
}
