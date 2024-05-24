import 'package:flutter/material.dart';
import 'package:instaapp/cubit/cubit/comments_cubit.dart';
import 'package:instaapp/widget/commentlisttile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPageListView extends StatelessWidget {
  const CommentPageListView({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsCubit(),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('comments')
            .where('postid', isEqualTo: data['postid']).snapshots(),
       
         
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshots.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(child: Text('No comments yet'));
          }

          return ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = snapshots.data!.docs[index].data() as Map<String, dynamic>;
              // Debug print to check data
              print('Comment data: $data');
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommentListTile(data: data),
              );
            },
          );
        },
      ),
    );
  }
}
