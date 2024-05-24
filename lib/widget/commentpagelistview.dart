import 'package:flutter/material.dart';
import 'package:instaapp/widget/commentlisttile.dart';

class commentspagelistview extends StatelessWidget {
  const commentspagelistview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return CommentListTile();
      },
    );
  }
}