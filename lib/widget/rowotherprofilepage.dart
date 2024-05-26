import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaapp/constatnt.dart';
class Rowotherprofilepage extends StatelessWidget {
  const Rowotherprofilepage({super.key, required this.mydata});
  final QueryDocumentSnapshot mydata;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('posts').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('User data not found'));
        } else {
          final user = snapshot.data!;
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where('username', isEqualTo: mydata['name'])
                .snapshots(),
            builder: (context, postSnapshot) {
              if (postSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (postSnapshot.hasError) {
                return Center(child: Text('Error: ${postSnapshot.error}'));
              } else if (!postSnapshot.hasData) {
                return Center(child: Text('No posts found'));
              } else {
                final postCount = postSnapshot.data!.docs.length;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(myimg),
                        ),
                        Text(mydata['name']),
                      ],
                    ),
                    Column(
                      children: [
                        Text('posts'),
                        Text(postCount.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Text('followers'),
                        Text(mydata['followers'].length.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Text('following'),
                        Text(mydata['following'].length.toString()),
                      ],
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    );;
  }
}