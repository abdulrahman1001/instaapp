import 'package:flutter/material.dart';
import 'package:instaapp/helpermethods/firestoremethos.dart';
import 'package:instaapp/models/usermodel.dart';
import 'package:instaapp/view/chatpage.dart';
import 'package:instaapp/view/loginpage.dart';

class appbarhomepage extends StatelessWidget {
  const appbarhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Instagram',
            style: TextStyle(fontSize: 30),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              icon: Icon(
                Icons.logout,
                size: 30,
              )),
                  IconButton(
              onPressed: () async {
                usermodel user= await FirestoreMethods().getUser();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {

                  return ChatPage(name: user.name,);
                }));
              },
              icon: Icon(
                Icons.comment,
                size: 30,
              )),
        ],
      ),
    );
  }
}
