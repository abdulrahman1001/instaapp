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

  Future<void> deletepost({required Map<String, dynamic> post}) async {
    try {
      usermodel user = await getUser();
      if (user.id == post['uid']) {
        // Assuming 'uid' is the post owner's ID
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

  Future<void> uploadComments(
      {required Map<String, dynamic> post, required String description}) async {
    try {
      usermodel user = await getUser();
      DocumentReference postRef =
          FirebaseFirestore.instance.collection('comments').doc();

      // Store comment data in Firestore
      await postRef.set({
        'commentId': postRef.id, // Add the commentId field
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
// Future<void> addFollow(String userIdToFollow) async {
//   try {
//     // Get the current logged-in user
//     usermodel user = await getUser();

//     // Find the document reference of the user to follow based on their userId
//     QuerySnapshot querySnapshotToFollow = await FirebaseFirestore.instance
//         .collection('users')
//         .where('id', isEqualTo: userIdToFollow)
//         .limit(1)
//         .get();

//     if (querySnapshotToFollow.docs.isEmpty) {
//       throw Exception('User to follow not found');
//     }

//     DocumentReference userToFollowRef = querySnapshotToFollow.docs.first.reference;

//     // Find the document reference of the current user based on their userId
//     QuerySnapshot querySnapshotCurrentUser = await FirebaseFirestore.instance
//         .collection('users')
//         .where('id', isEqualTo: user.id)
//         .limit(1)
//         .get();

//     if (querySnapshotCurrentUser.docs.isEmpty) {
//       throw Exception('Current user document not found');
//     }

//     DocumentReference currentUserRef = querySnapshotCurrentUser.docs.first.reference;

//     // Update the current user's following list
//     await currentUserRef.update({
//       'following': FieldValue.arrayUnion([userIdToFollow])
//     });

//     // Update the followed user's followers list
//     await userToFollowRef.update({
//       'followers': FieldValue.arrayUnion([user.id])
//     });

//     print('User followed successfully');
//   } catch (e) {
//     print("Error in addFollow: $e");
//     throw Exception("Error following user: $e");
//   }
// }

// Future<void> unfollow(String userIdToFollow) async {
//   try {
//     // Get the current logged-in user
//     usermodel user = await getUser();

//     // Find the document reference of the user to follow based on their userId
//     QuerySnapshot querySnapshotToFollow = await FirebaseFirestore.instance
//         .collection('users')
//         .where('id', isEqualTo: userIdToFollow)
//         .limit(1)
//         .get();

//     if (querySnapshotToFollow.docs.isEmpty) {
//       throw Exception('User to follow not found');
//     }

//     DocumentReference userToFollowRef = querySnapshotToFollow.docs.first.reference;

//     // Find the document reference of the current user based on their userId
//     QuerySnapshot querySnapshotCurrentUser = await FirebaseFirestore.instance
//         .collection('users')
//         .where('id', isEqualTo: user.id)
//         .limit(1)
//         .get();

//     if (querySnapshotCurrentUser.docs.isEmpty) {
//       throw Exception('Current user document not found');
//     }

//     DocumentReference currentUserRef = querySnapshotCurrentUser.docs.first.reference;

//     // Update the current user's following list
//     await currentUserRef.update({
//       'following': FieldValue.arrayRemove([userIdToFollow])
//     });

//     // Update the followed user's followers list
//     await userToFollowRef.update({
//       'followers': FieldValue.arrayRemove([user.id])
//     });

//     print('User followed successfully');
//   } catch (e) {
//     print("Error in addFollow: $e");
//     throw Exception("Error following user: $e");
//   }
// }

Future<bool> isFollowing(String userIdToCheck) async {
    try {
      usermodel user = await getUser();

      QuerySnapshot querySnapshotCurrentUser = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.id)
          .limit(1)
          .get();

      if (querySnapshotCurrentUser.docs.isEmpty) {
        throw Exception('Current user document not found');
      }

      DocumentSnapshot currentUserSnap = querySnapshotCurrentUser.docs.first;
      Map<String, dynamic>? currentUserData = currentUserSnap.data() as Map<String, dynamic>?;
      List<dynamic> following = currentUserData?['following'] ?? [];

      return following.contains(userIdToCheck);
    } catch (e) {
      print("Error in isFollowing: $e");
      throw Exception("Error checking follow status: $e");
    }
  }

  Future<void> toggleFollow(String userIdToFollow) async {
    try {
      usermodel user = await getUser();

      QuerySnapshot querySnapshotToFollow = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userIdToFollow)
          .limit(1)
          .get();

      if (querySnapshotToFollow.docs.isEmpty) {
        throw Exception('User to follow not found');
      }

      DocumentReference userToFollowRef = querySnapshotToFollow.docs.first.reference;

      QuerySnapshot querySnapshotCurrentUser = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.id)
          .limit(1)
          .get();

      if (querySnapshotCurrentUser.docs.isEmpty) {
        throw Exception('Current user document not found');
      }

      DocumentReference currentUserRef = querySnapshotCurrentUser.docs.first.reference;

      DocumentSnapshot currentUserSnapshot = await currentUserRef.get();
      Map<String, dynamic>? currentUserData = currentUserSnapshot.data() as Map<String, dynamic>?;
      List<dynamic> followingList = currentUserData?['following'] ?? [];

      if (followingList.contains(userIdToFollow)) {
        await currentUserRef.update({
          'following': FieldValue.arrayRemove([userIdToFollow])
        });

        await userToFollowRef.update({
          'followers': FieldValue.arrayRemove([user.id])
        });

        print('User unfollowed successfully');
      } else {
        await currentUserRef.update({
          'following': FieldValue.arrayUnion([userIdToFollow])
        });

        await userToFollowRef.update({
          'followers': FieldValue.arrayUnion([user.id])
        });

        print('User followed successfully');
      }
    } catch (e) {
      print("Error in toggleFollow: $e");
      throw Exception("Error toggling follow status: $e");
    }
  }
  }

    
    

  

