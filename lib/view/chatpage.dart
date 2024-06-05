import 'package:flutter/material.dart';
import 'package:instaapp/widget/listviewchatpage.dart';

class ChatPage extends StatelessWidget {
  final String name;

  ChatPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
                Text(
                  'Chat Page',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ),
          Expanded(child: listviewchatpage(username: name)),
        ]),
      ),
    );
  }
}
