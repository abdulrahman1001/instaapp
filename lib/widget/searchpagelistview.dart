import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaapp/widget/searchquary.dart';

class SearchPageListView extends StatelessWidget {
  const SearchPageListView({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Center(child: Text('Please enter a name to search'));
    }

    String startText = text;
    String endText = text + '\uf8ff';

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('users')
          .where('name', isGreaterThanOrEqualTo: startText)
          .where('name', isLessThan: endText)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No users found'));
        } else {
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchQuery(mydata: user),
              );
            },
          );
        }
      },
    );
  }
}
