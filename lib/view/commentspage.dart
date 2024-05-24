import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';
import 'package:instaapp/widget/commentlisttile.dart';
import 'package:instaapp/widget/commentpagelistview.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          
          Expanded(child: commentspagelistview()),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(myimg),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Comment',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
