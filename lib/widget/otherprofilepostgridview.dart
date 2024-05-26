import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtherPostGridView extends StatelessWidget {
  const OtherPostGridView({super.key, required this.mydata});
  final QueryDocumentSnapshot mydata;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('posts').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('User data not found'));
        } else {
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('username', isEqualTo: mydata['name'])
                .get(),
            builder: (context, postSnapshot) {
              if (postSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (postSnapshot.hasError) {
                return Center(child: Text('Error: ${postSnapshot.error}'));
              } else if (!postSnapshot.hasData ||
                  postSnapshot.data!.docs.isEmpty) {
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
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // You can use the data from 'posts' to display actual content
                    final post = posts[index];
                    return Container(
                      color: Colors.amber,
                      child: Center(
                        child: Text(post['title']), // Assuming 'title' is a field in your posts collection
                      ),
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
