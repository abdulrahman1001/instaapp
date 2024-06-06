import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class chatbuble extends StatelessWidget {
  const chatbuble({super.key, required this.mydata});
  final QueryDocumentSnapshot mydata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back)),
                  CircleAvatar(
                    backgroundImage: NetworkImage(mydata['img']),
                  ),
                  Text(mydata['name'])
                ],
              ),
            ),
          ],
        ),
      ) ,
    ) ;
  }
}