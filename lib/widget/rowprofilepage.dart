import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';

class rowprofilepage extends StatelessWidget {
  const rowprofilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return      Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(myimg),
                    ),
                    Text('username')
                  ],
                ),
                Column(
                  children: [
                    Text('posts'),
                    Text('0'),
                  ],
                ),
                Column(
                  children: [
                    Text('followers'),
                    Text('0'),
                  ],
                ),
                Column(
                  children: [
                    Text('following'),
                    Text('0'),
                  ],
                ),
              ],
            );
  }
}