import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchQuery extends StatelessWidget {
  const SearchQuery({super.key, required this.mydata});
  final QueryDocumentSnapshot mydata;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(mydata['name']),
      trailing: Container(
        width: 50,  // Adjusted size to fit better
        height: 50,  // Adjusted size to fit better
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage( myimg),  // Ensure mydata contains profile_image or fallback to myimg
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
