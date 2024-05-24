import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaapp/models/usermodel.dart';

class FirestoreMethods {
  Future<usermodel> getUser() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("No user is currently logged in");
      }

      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!snap.exists) {
        throw Exception("User document does not exist");
      }

      return usermodel.fromSnap(snap);
    } catch (e) {
      print("Error in getUser: $e");
      throw Exception("Error fetching user data: $e");
    }
  }

  Future<void> addlike(String postId) async {
    try {
      usermodel user = await getUser();
      FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion(
            [user.id]) // Assuming 'uid' is the unique identifier
      });
    } catch (e) {
      print("Error in addlike: $e");
      throw Exception("Error adding like: $e");
    }
  }

  Future<void> removelike(String postId) async {
    try {
      usermodel user = await getUser();
      FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove(
            [user.id]) // Assuming 'uid' is the unique identifier
      });
    } catch (e) {
      print("Error in removelike: $e");
      throw Exception("Error removing like: $e");
    }
  }

  deletepost({required Map post}) async {
    usermodel user = await getUser();
    if (user.id == post['postid']) {
      {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(post['postid'])
            .delete();
        print('Post deleted successfully');
      }
    }
  }
}
