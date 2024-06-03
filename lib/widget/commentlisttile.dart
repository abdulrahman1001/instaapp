import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';

class CommentListTile extends StatelessWidget {
  const CommentListTile({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data['username']),
      subtitle: Text(data['description']),
      trailing: Icon(Icons.favorite),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data['userimage']??myimg),
      ),
    );
  }
}