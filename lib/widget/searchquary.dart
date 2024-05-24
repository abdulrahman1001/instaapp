import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';

class searcquery extends StatelessWidget {
  const searcquery({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('name'),
      trailing:Container(
  width: 130,
  height: 130,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
      image:  NetworkImage(myimg),
      fit: BoxFit.fill
    ),
  ),
),
    ) ;
  }
}