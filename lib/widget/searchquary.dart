import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaapp/view/otheruserprofilepage.dart';

class SearchQuery extends StatelessWidget {
  const SearchQuery({super.key, required this.mydata});
  final QueryDocumentSnapshot mydata;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  OtherUserProfilePage(mydata: mydata,)),
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
