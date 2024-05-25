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
        'likes': FieldValue.arrayUnion([user.id]) // Assuming 'uid' is the unique identifier
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
        'likes': FieldValue.arrayRemove([user.id]) // Assuming 'uid' is the unique identifier
      });
    } catch (e) {
      print("Error in removelike: $e");
      throw Exception("Error removing like: $e");
    }
  }

  Future<void> deletepost({required Map<String, dynamic> post}) async {
    try {
      usermodel user = await getUser();
      if (user.id == post['uid']) { // Assuming 'uid' is the post owner's ID
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(post['postid'])
            .delete();
        print('Post deleted successfully');
      } else {
        print('You do not have permission to delete this post');
      }
    } catch (e) {
      print("Error in deletepost: $e");
      throw Exception("Error deleting post: $e");
    }
  }
  
      
  Future<void> uploadComments({required Map<String, dynamic> post, required String description}) async {
  try {
    usermodel user = await getUser();
    DocumentReference postRef = FirebaseFirestore.instance.collection('comments').doc();
    
    // Store comment data in Firestore
    await postRef.set({
      'commentId': postRef.id,  // Add the commentId field
      'postid': post['postid'], // Ensure this refers to the post's ID
      'username': user.name,
      'uid': user.id,
      'userimage': user.img ?? '',
      'description': description,
      'likes': [],
      'date': DateTime.now() // Optional: Add a timestamp field
    });

    print('Comment uploaded successfully');
  } catch (e) {
    print("Error in uploadComments: $e");
    throw Exception("Error uploading comment: $e");
  }
}

}