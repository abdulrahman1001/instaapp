import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsInitial());
  List comments = [];

  void getcomments() {
    emit(CommentsLoadingstate());
      DocumentReference postRef = FirebaseFirestore.instance.collection('comments').doc();
      

      

  }
}
