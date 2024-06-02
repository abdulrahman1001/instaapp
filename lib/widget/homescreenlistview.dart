import 'package:flutter/material.dart';
import 'package:instaapp/widget/homepagewidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaapp/cubit/cubit/fetshuserdata_cubit.dart';

class homescreenlistview extends StatelessWidget {
  const homescreenlistview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetshuserdataCubit()..fetshuserdata(),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshots.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(child: Text('No posts yet'));
          }

          return ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = snapshots.data!.docs[index].data() as Map<String, dynamic>;
              // Debug print to check data
              print('Post data: $data');
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Homepagewidget(
                  key: ValueKey(data['postid']), // Ensure unique key for each widget
                  data: data,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
