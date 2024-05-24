import 'package:flutter/material.dart';
import 'package:instaapp/widget/searchpagelistview.dart';

class searchpage extends StatelessWidget {
  const searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
          ),
          searchpagelistview()
        ],
      ),
    );
  }
}