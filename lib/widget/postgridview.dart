import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaapp/helpermethods/firestoremethos.dart';
import 'package:instaapp/models/usermodel.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<usermodel>(
      future: FirestoreMethods().getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('User data not found'));
        } else {
          final user = snapshot.data!;
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('username', isEqualTo: user.name)
                .get(),
            builder: (context, postSnapshot) {
              if (postSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (postSnapshot.hasError) {
                return Center(child: Text('Error: ${postSnapshot.error}'));
              } else if (!postSnapshot.hasData || postSnapshot.data!.docs.isEmpty) {
                return Center(child: Text('No posts found'));
              } else {
                final posts = postSnapshot.data!.docs;
                return GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 5,
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    final post = posts[index].data() as Map<String, dynamic>;
                    return Container(
                      child: Image.network(post['postimage']),
                    );
                  },
                  itemCount: posts.length,
                );
              }
            },
          );
        }
      },
    );
  }
}
