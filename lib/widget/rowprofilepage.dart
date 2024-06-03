import 'package:flutter/material.dart';
import 'package:instaapp/constatnt.dart';
import 'package:instaapp/helpermethods/firestoremethos.dart';
import 'package:instaapp/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowProfilePage extends StatefulWidget {
  const RowProfilePage({super.key});

  @override
  State<RowProfilePage> createState() => _RowProfilePageState();
}

class _RowProfilePageState extends State<RowProfilePage> {
  late Future<usermodel> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = FirestoreMethods().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<usermodel>(
      future: futureUser,
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
                .where('username', isEqualTo: user.name)
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
                          backgroundImage: NetworkImage(user.img),
                        ),
                        Text(user.name),
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
                        Text(user.followers.length.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Text('following'),
                        Text(user.following.length.toString()),
                      ],
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }
}
