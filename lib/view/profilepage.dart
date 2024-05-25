import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';
import 'package:instaapp/widget/postgridview.dart';
import 'package:instaapp/widget/rowprofilepage.dart';

class profilepage extends StatelessWidget {
  const profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
             RowProfilePage(),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            alignment: Alignment.bottomCenter,
            child: Text('edit profile'),
          ),
        PostGridView (),
      
        ],
      ),
    );
  }
}
