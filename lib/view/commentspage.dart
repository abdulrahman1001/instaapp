import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';
import 'package:instaapp/helpermethods/firestoremethos.dart';
import 'package:instaapp/widget/commentlisttile.dart';
import 'package:instaapp/widget/commentpagelistview.dart';


class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key, required this.data});
    final Map<String, dynamic> data;

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();

  
  

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
          Expanded(child: CommentPageListView(data: widget.data,)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(myimg),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Stack(
                    children: [
                      TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Comment',
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: (){
                            FirestoreMethods().uploadComments(post: widget.data, description: _commentController.text);
                            _commentController.clear();
                          },
                        ),
                      ),
                    ],
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
