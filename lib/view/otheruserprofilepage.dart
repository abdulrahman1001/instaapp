import 'package:flutter/material.dart';
import 'package:instaapp/helpermethods/firestoremethos.dart';
import 'package:instaapp/widget/otherprofilepostgridview.dart';
import 'package:instaapp/widget/postgridview.dart';
import 'package:instaapp/widget/rowotherprofilepage.dart';
import 'package:instaapp/widget/rowprofilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class OtherUserProfilePage extends StatefulWidget {
  const OtherUserProfilePage({super.key, required this.mydata});
  final QueryDocumentSnapshot mydata;

  @override
  _OtherUserProfilePageState createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    checkIfFollowing();
  }

  void checkIfFollowing() async {
    bool followingStatus = await FirestoreMethods().isFollowing(widget.mydata['id']);
    setState(() {
      isFollowing = followingStatus;
    });
  }

  void toggleFollow() async {
    await FirestoreMethods().toggleFollow(widget.mydata['id']);
    checkIfFollowing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Rowotherprofilepage(mydata: widget.mydata),
            GestureDetector(
              onTap: toggleFollow,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: isFollowing ? Colors.red : Colors.green,
                alignment: Alignment.bottomCenter,
                child: Text(isFollowing ? 'Unfollow' : 'Follow'),
              ),
            ),
            Expanded(child: OtherPostGridView(mydata: widget.mydata)),
          ],
        ),
      ),
    );
  }
}
