import 'dart:typed_data';
import 'dart:io' as io;
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:instaapp/models/usermodel.dart';

part 'authtecate_state.dart';

class AuthtecateCubit extends Cubit<AuthtecateState> {
  AuthtecateCubit() : super(AuthtecateInitial());
  String emailuser = '';
  setemail(String email){
emailuser = email;
  }

  String img = '';

  Future<void> getimgWeb(Uint8List imgBytes) async {
    try {
      final id = Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child('userimg').child('$id.jpg');
      await ref.putData(imgBytes);
      img = await ref.getDownloadURL();
      emit(AuthtecateImageUploadSuccess(img));
    } catch (e) {
      emit(AuthtecateErrorstate(e.toString()));
    }
  }

  Future<void> getimgMobile(io.File imgFile) async {
    try {
      final id = Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child('userimg').child('$id.jpg');
      await ref.putFile(imgFile);
      img = await ref.getDownloadURL();
      emit(AuthtecateImageUploadSuccess(img));
    } catch (e) {
      emit(AuthtecateErrorstate(e.toString()));
    }
  }

  Future<void> createUser(String email, String password, String name) async {
    final id = Uuid().v4(); // Generate a new ID for each user
    usermodel user = usermodel(
      name: name,
      email: email,
      password: password,
      id: id,
      img: img,
      followers: [],
      following: [],
    );
    emit(AuthtecateLoadingstate());
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.usertoMap());
      emit(AuthtecateSuccessstate());
    } catch (e) {
      emit(AuthtecateErrorstate(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthtecateLoadingstate());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      this.emailuser = email;
      emit(AuthtecateSuccessstate());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      emit(AuthtecateErrorstate(e.toString()));
    }
  }

  Future<usermodel?> getUserByEmail(String email) async {
    try {
      final userQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        throw Exception('User not found');
      }

      return usermodel.fromSnap(userQuerySnapshot.docs.first);
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

}
