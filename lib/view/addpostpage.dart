import 'package:flutter/material.dart';
import 'package:instaapp/cubit/cubit/authtecate_cubit.dart';
import 'package:instaapp/helpermethods/takephoto.dart';
import 'dart:typed_data';
import 'dart:io' as io;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instaapp/models/usermodel.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Photo photo = Photo();
  Uint8List? pickedImgWeb;
  io.File? pickedImgMobile;
  TextEditingController controller = TextEditingController();

  Future<void> uploadPost() async {
    try {
      String? imageUrl;
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("No user is currently logged in");
      }

      final String userId = currentUser.uid;
      final String email = currentUser.email!;

      // Upload image to Firebase Storage
      if (pickedImgWeb != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('postImages')
            .child('$userId-web.jpg');
        await ref.putData(pickedImgWeb!);
        imageUrl = await ref.getDownloadURL();
        print('Image uploaded for web: $imageUrl');
      } else if (pickedImgMobile != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('postImages')
            .child('$userId-mobile.jpg');
        await ref.putFile(pickedImgMobile!);
        imageUrl = await ref.getDownloadURL();
        print('Image uploaded for mobile: $imageUrl');
      }

      if (imageUrl != null) {
        print('Image URL: $imageUrl');
        
        // Fetch user data
        usermodel? user = await BlocProvider.of<AuthtecateCubit>(context).getUserByEmail(email);
        if (user != null) {
          // Create a new document reference with a custom ID
          DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc();
          
          // Store post data in Firestore
          await postRef.set({
            'postid': postRef.id,  // Add the postid field
            'username': user.name,
            'uid': user.id,
            'userimage': user.img ?? '',
            'description': controller.text,
            'postimage': imageUrl,
            'likes': [],
            'timestamp': FieldValue.serverTimestamp(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Post uploaded successfully!')));

          // Clear image and description
          setState(() {
            pickedImgWeb = null;
            pickedImgMobile = null;
            controller.clear();
          });

          // Example usage of addlike method with the postId
         
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User information could not be retrieved.')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select an image to upload.')));
      }
    } catch (e) {
      print('Upload failed: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload post: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthtecateCubit, AuthtecateState>(
      listener: (context, state) {
        if (state is AuthtecateImageUploadSuccess) {
          setState(() {
            pickedImgWeb = photo.pickedImgWeb;
            pickedImgMobile = photo.pickedImgMobile;
          });
        } else if (state is AuthtecateErrorstate) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('New Post'),
          actions: [
            TextButton(
              onPressed: () async {
                await uploadPost();
              },
              child: Text(
                'Post',
                style: TextStyle(color: Colors.blue, fontSize: 19),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: pickedImgWeb != null
                  ? Image.memory(pickedImgWeb!)
                  : pickedImgMobile != null
                      ? Image.file(pickedImgMobile!)
                      : Center(child: Text('No image selected')),
            ),
            IconButton(
                onPressed: () async {
                  await photo.takeImage(context, onPressed: () {
                    setState(() {
                      pickedImgWeb = photo.pickedImgWeb;
                      pickedImgMobile = photo.pickedImgMobile;
                    });
                    print('Image selected');
                  });
                },
                icon: Icon(Icons.upload)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add content',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
