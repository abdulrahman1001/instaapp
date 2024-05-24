import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';

class CommentListTile extends StatelessWidget {
  const CommentListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('name'),
      subtitle: Text('comment'),
      trailing: Icon(Icons.favorite),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(myimg),
      ),
    );
  }
}