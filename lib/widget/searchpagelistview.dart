import 'package:flutter/material.dart';
import 'package:instaapp/widget/searchquary.dart';

class searchpagelistview extends StatelessWidget {
  const searchpagelistview({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
       return   Padding(
         padding: const EdgeInsets.all(8.0),
        
         child:searcquery() ,
       );
        },
      ),
    );
  }
}