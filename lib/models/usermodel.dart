import 'package:cloud_firestore/cloud_firestore.dart';

class usermodel {
  final String name;
  final String email;
  final String password;
  final String id;
  final String img;
  final List followers;
  final List following;

  usermodel({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    required this.img,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> usertoMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'id': id,
      'img': img,
      'followers': followers,
      'following': following,
    };
  }

  static usermodel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return usermodel(
      name: snapshot['name'] ?? 'Anonymous',
      email: snapshot['email'],
      password: snapshot['password'],
      id: snapshot['id'],
      img: snapshot['img'],
      followers: snapshot['followers'] ?? [],
      following: snapshot['following'] ?? [],
    );
  }
}
