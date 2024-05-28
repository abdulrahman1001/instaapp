import 'package:flutter/material.dart';
import 'package:instaapp/helpermethods/firestoremethos.dart';
import 'package:instaapp/widget/otherprofilepostgridview.dart';
import 'package:instaapp/widget/postgridview.dart';
import 'package:instaapp/widget/rowotherprofilepage.dart';
import 'package:instaapp/widget/rowprofilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class OtherUserProfilePage extends StatelessWidget {
  const OtherUserProfilePage({super.key, required this.mydata});
  final QueryDocumentSnapshot mydata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
             Rowotherprofilepage(mydata: mydata,),
          GestureDetector(
            onTap: () {
              FirestoreMethods().addFollow(mydata['id']);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              alignment: Alignment.bottomCenter,
              child: Text('follow'),
            ),
          ),
          Expanded(child: OtherPostGridView (mydata: mydata,)),
      
        ],
      ),
    ),
    );
  }
}
