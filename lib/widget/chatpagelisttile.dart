import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaapp/widget/chatbuble.dart';
class ChatPagelisttile extends StatelessWidget {
  const ChatPagelisttile({super.key, required this.mydata});
  final QueryDocumentSnapshot mydata;
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  chatbuble(mydata: mydata,)),
        );
      },
      child: ListTile(
        title: Text(mydata['name']),
        trailing: Container(
          width: 50,  // Adjusted size to fit better
          height: 50,  // Adjusted size to fit better
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage( mydata['img']),  // Ensure mydata contains profile_image or fallback to myimg
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}